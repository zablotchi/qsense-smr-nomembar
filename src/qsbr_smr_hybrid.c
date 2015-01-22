#include <stdio.h>
#include <stdlib.h>
#include "qsbr_smr_hybrid.h"
#include "mr.h"
#include "ssalloc.h"
#include "atomic_ops_if.h"
#include "utils.h"
#include "lock_if.h"
#include "linkedlist-qsbr-smr-hybrid/linkedlist.h"

struct qsbr_globals *qg ALIGNED(CACHE_LINE_SIZE);

shared_thread_data_t *shtd;

__thread local_thread_data_t ltd;

int compare (const void *a, const void *b);
uint8_t is_old_enough(mr_node_t* n);
inline int ssearch(void **list, size_t size, void *key);
void reset_presence();
int all_threads_present();
int nthreads_;

volatile uint8_t *is_present_vect;

void mr_init_local(uint64_t thread_index, uint64_t nthreads) {
    ltd.thread_index = thread_index;
    ltd.nthreads = nthreads;
    ltd.rcount = 0;
    ltd.plist = (void **) malloc(sizeof(void *) * K * nthreads);
    ltd.last_flag = 0;
}

// TODO IGOR OANA add NULL verification after memory allocation
void mr_init_global(uint64_t nthreads) {
    int i, j;
    
    nthreads_ = nthreads;
    qg = (struct qsbr_globals *) malloc(sizeof(struct qsbr_globals));
    qg->global_epoch = 1;
    INIT_LOCK(&(qg->update_lock));

    shtd = (shared_thread_data_t *) malloc(nthreads * sizeof(shared_thread_data_t));

    for (i = 0; i < nthreads; i++) {
        shtd[i].epoch = 0;
        shtd[i].in_critical = 1;
        shtd[i].process_callbacks_count = 0;
        shtd[i].scan_count = 0;
        //shtd[i].is_present = 1;
        for (j = 0; j < N_EPOCHS; j++) {
            init(shtd[i].limbo_list[j]);
        }
    }

    HP = (hazard_pointer_t *)malloc(sizeof(hazard_pointer_t) * K*nthreads);

    for (i = 0; i < K*(nthreads); i++) {
        HP[i].p = NULL;
    }

    is_present_vect = (uint8_t*) malloc(sizeof(uint8_t) * nthreads);
    for (i = 0; i < nthreads; i++) {
        is_present_vect[i] = 1;
    }

    fallback.flag = 0;

    //create sleeper threads
    init_sleeper_threads(nthreads, reset_presence);
    
}

void mr_exit_global(){
    //join sleeper threads
    join_sleeper_threads();
}

void mr_thread_exit()
{
    // Hazard pointer-style exit every time just to be safe
    // IGOR OANA if we end up having rooster threads only in case of fallback mode
    // will it not be a problem to use HP style exit?
    int i;
    
    for (i = 0; i < K; i++)
        HP[K * ltd.thread_index + i].p = NULL;
    
    // printf("Exiting now, max retries = %d\n", MAX_EXIT_RETRIES);
    int retries = 0;

    while (ltd.rcount > 0 && retries < MAX_EXIT_RETRIES) {
        scan();
        sched_yield();
        retries++;
    }

    // printf("Scan count = %d; Retries = %d\n", shtd[ltd.thread_index].scan_count, retries);


}

void mr_reinitialize()
{
    //TODO: rethink this
    qg->global_epoch = 1;
    int i;
    for (i = 0; i < ltd.nthreads; i++) {
        shtd[i].epoch = 0;
    }
}

int update_epoch()
{
    int curr_epoch;
    int i;
    
    // if (!spin_trylock(&qg->update_lock)) {
    if (!TRYLOCK(&qg->update_lock)) {
        /* Someone could be preempted while holding the update lock. Give
         * them the CPU. */
        /*cond_yield();*/
        return 0;
    }
    
    /* If any CPU hasn't advanced to the current epoch, abort the attempt. */
    curr_epoch = qg->global_epoch;
    for (i = 0; i < ltd.nthreads; i++) {
        if (shtd[i].in_critical == 1 && 
            shtd[i].epoch != curr_epoch &&
            i != ltd.thread_index) {
            UNLOCK(&qg->update_lock);
            /*cond_yield();*/
            return 0;
        }
    }
    
    /* Update the global epoch. 
     * 
     * I wanted to use CAS here, but that would be unsafe due to 
     * wraparound. */
    qg->global_epoch = (curr_epoch + 1) % N_EPOCHS;
    
    UNLOCK(&(qg->update_lock));
    return 1;
}

/* Processes a list of callbacks.
 *
 * @list: Pointer to list of node_t's.
 */
void process_callbacks(double_llist_t *list)
{
    mr_node_t *n;
    uint64_t num = 0;
    
    // write_barrier(); // IGOR why you do this?
    MEM_BARRIER;

    while (list->head != NULL) {
        n = remove_from_tail(list);
        
        ((node_t *) (n->actual_node))->key = 10000;
        ssfree_alloc(0, n->actual_node);
        ssfree_alloc(1, n);
        num++;
    }

    shtd[ltd.thread_index].process_callbacks_count+=num;
    /* Update our accounting information. */
    ltd.rcount -= num;
}

/* 
 * Informs other threads that this thread has passed through a quiescent 
 * state.
 * If all threads have passed through a quiescent state since the last time
 * this thread processed it's callbacks, proceed to process pending callbacks.
 */
void quiescent_state (int blocking)
{
    // struct per_thread *t = this_thread();
    uint64_t my_index = ltd.thread_index;
    int epoch;
    int orig;

 retry:    
    epoch = qg->global_epoch;
    if (shtd[my_index].epoch != epoch) { /* New epoch. */
        /* Process callbacks for old 'incarnation' of this epoch. */
        process_callbacks(shtd[my_index].limbo_list[epoch]);
        shtd[my_index].epoch = epoch;
    } else {
        orig = shtd[my_index].in_critical;
        shtd[my_index].in_critical = 0;
        int res = update_epoch();
        if (res) {
            shtd[my_index].in_critical = orig; 
            MEM_BARRIER;
            epoch = qg->global_epoch;
            if (shtd[my_index].epoch != epoch) {
                process_callbacks(shtd[my_index].limbo_list[epoch]);
                shtd[my_index].epoch = epoch;
            }
            return;
        } else if (blocking) {
            shtd[my_index].in_critical = orig; 
            MEM_BARRIER;
            sched_yield();
            goto retry;
        }
        shtd[my_index].in_critical = orig; 
        MEM_BARRIER;
    }
    
    return;
}

/* Links the node into the per-thread list of pending deletions.
 */
void free_node_later (void *q)
{
    uint64_t my_index = ltd.thread_index;

    mr_node_t* wrapper_node = ssalloc_alloc(1, sizeof(mr_node_t));
    wrapper_node->actual_node = q;
    // Create timestamp in mr node
    gettimeofday(&(wrapper_node->created), NULL);

    add_to_head(shtd[my_index].limbo_list[shtd[my_index].epoch], wrapper_node);
    ltd.rcount++;

    if (fallback.flag == 1 && ltd.rcount >= R) {

        scan();
    }
}

// Hazard Pointers Specific
void scan()
{

    /* Iteratation variables. */
    mr_node_t *cur;
    int i,j;
    uint64_t my_index = ltd.thread_index;

    shtd[my_index].scan_count++;

    /* List of SMR callbacks. */
    mr_node_t *tmplist;

    /* List of hazard pointers, and its size. */
    void **plist = ltd.plist;
    size_t psize;

    /*
     * Make sure that the most recent node to be deleted has been unlinked
     * in all processors' views.
     */
    // write_barrier();
    MEM_BARRIER;

    /* Stage 1: Scan HP list and insert non-null values in plist. */
    psize = 0;
    for (i = 0; i < H; i++) {
        if (HP[i].p != NULL)
            plist[psize++] = HP[i].p;
    }
    
    /* Stage 2: Sort the plist. */
    // IGOR OANA Don't sort; we are doing linear search
    // qsort(plist, psize, sizeof(mr_node_t *), compare);

    /* Stage 3: Free non-harzardous nodes. */
    //OANA Modified Scan (a lot)
    ltd.rcount = 0;
    for (j = 0; j < N_EPOCHS; j++){
        tmplist = shtd[my_index].limbo_list[j]->head;
        shtd[my_index].limbo_list[j]->head = NULL;

        //tmplist = this_thread()->rlist;
        //this_thread()->rlist = NULL;
        //this_thread()->rcount = 0;
        while (tmplist != NULL) {
            /* Pop cur off top of tmplist. */
            cur = tmplist;
            tmplist = tmplist->mr_next;

            if (!is_old_enough(cur) || ssearch(plist, psize, cur->actual_node)) {
                //cur->mr_next = this_thread()->rlist;
                //this_thread()->rlist = cur;

                cur->mr_next = shtd[my_index].limbo_list[j]->head;
                shtd[my_index].limbo_list[j]->head = cur;
                ltd.rcount++;
            } else {
                ((node_t *)(cur->actual_node))->key = 10000;      
                ssfree_alloc(0, cur->actual_node);
                ssfree_alloc(1, cur);
            }
        }
    }
}

uint8_t is_old_enough(mr_node_t* n) {
    struct timeval now;
    gettimeofday(&now, NULL);
    uint64_t msec; 
    msec = (now.tv_sec - n->created.tv_sec) * 1000; 
    msec += (now.tv_usec - n->created.tv_usec) / 1000; 
    return (msec >= (SLEEP_AMOUNT + MARGIN)); 
}

void allocate_fail(int trials) {

    shtd[ltd.thread_index].allocate_fail_count ++;

    volatile uint8_t flag = fallback.flag;

    if (ltd.last_flag == 1 && flag == 0) {
        int i;
        for (i = 0; i < 100; i++) {
            quiescent_state(FUZZY);
        }
        printf("[%d] Quiescing before switch to QSBR from allocate_fail. Rcount:%d\n", ltd.thread_index, ltd.rcount);
        ltd.last_flag = 0;
    } else if (flag == 1) {
        scan();
        ltd.last_flag = 1;
    } else if (flag == 0 && trials >= SWITCH_THRESHOLD) {
        fallback.flag = 1;
        ltd.last_flag = 1;
        fprintf(stderr, "[%d] Switched to SMR: %d\n", ltd.thread_index, trials);
        scan();
    } else { // flag == 0 and trials < SWITCH_THRESHOLD
        quiescent_state(FUZZY);
        ltd.last_flag = 0;
    }
}

void manage_hybrid_state(){
    //Signal to the other threads that 
    //thread is present in the system (not delayed) 

    //shtd[ltd.thread_index].is_present = 1;
    is_present_vect[ltd.thread_index] = 1;

    //r_count[ltd.thread_index] = ltd.rcount;
    volatile uint8_t flag = fallback.flag;

    int i;
    if (ltd.last_flag == 1 && flag == 0) {
        for (i = 0; i < 100; i++) {
            quiescent_state(FUZZY);
        }
        ltd.last_flag = 0;
        printf("[%d] Quiescing before switch to QSBR from test. Rcount:%d\n", ltd.thread_index, ltd.rcount);
    } else if (flag == 0) { 
        quiescent_state(FUZZY);
        ltd.last_flag = 0;
    } else if (flag == 1) {
        if (all_threads_present() == 1) {
            // mr_reinitialize();
            fallback.flag = 0;
            ltd.last_flag = 0;
            printf("[%d] Switched to QSBR. Rcount:%d\n", ltd.thread_index, ltd.rcount);
            for (i = 0; i < 10; i++) {
                quiescent_state(FUZZY);
            }
            // fallback.flag = 0;
        }
        ltd.last_flag = 1; 
    }
}

//Verify if all threads are currently active in the system
int all_threads_present(){
    int i;
    for (i=0; i < ltd.nthreads; i++){
        //if (shtd[i].is_present == 0){
        //    return 0;
        //}
        if (is_present_vect[i] == 0){
            return 0;
        }
    }
    return 1;
}


// UTILITY FUNCTIONS

/* 
 * Comparison function for qsort.
 *
 * We just need any total order, so we'll use the arithmetic order 
 * of pointers on the machine.
 *
 * Output (see "man qsort"):
 *  < 0 : a < b
 *    0 : a == b
 *  > 0 : a > b
 */
int compare (const void *a, const void *b)
{
  return ( *(mr_node_t **)a - *(mr_node_t **)b );
}

/* Debugging function. Leave it around. */
inline int ssearch(void **list, size_t size, void *key) {
    int i;
    for (i = 0; i < size; i++) {
      if (list[i] == key) {
        return 1;
      }
    }
    return 0;
}

void reset_presence(){    
    int i;

    for (i = 0; i < nthreads_; i++){
        //shtd[i].is_present = 0;
        is_present_vect[i] = 0;
    }  
}