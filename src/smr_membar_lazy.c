/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (c) Thomas E. Hart.
 */

#include "smr.h"
//#include "arch/atomic.h"
#include "ssalloc.h"
// #include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "linkedlist-smr-membar-lazy/linkedlist.h"
// #include "linkedlist-smr-hart/node.h"

// IGOR: SSALLOC allocator convention:
// 0 is for actual nodes
// 1 is for m_nodes

__thread smr_data_t sd;
__thread uint64_t HP_cur;
__thread uint64_t reclaimed_count;
void rotation();


void mr_init_global(uint8_t nthreads){
  /* Allocate HP array. Over-allocate since the parent has pid 32. */
  // HP = (hazard_pointer *)mapmem(sizeof(hazard_pointer) * K*(MAX_THREADS+1));
  HP = (hazard_pointer_t *)malloc(sizeof(hazard_pointer_t) * K*nthreads);
  if (HP == NULL) {
    fprintf(stderr, "SMR mr_init: out of memory\n");
    exit(-1);
  }

  /* Initialize the hazard pointers. */
  int i;
  for (i = 0; i < K*(nthreads); i++)
    HP[i].p = NULL;
}

void mr_init_local(uint8_t thread_index, uint8_t nthreads){

  sd.rlist = (double_llist_t*) malloc(sizeof(double_llist_t));
  init(sd.rlist);

  sd.rcount = 0;
  sd.thread_index = thread_index;
  sd.nthreads = nthreads;
  sd.plist = (void **) malloc(sizeof(void *) * K * sd.nthreads);
  HP_cur = 0;
  reclaimed_count = 0;

}


void mr_thread_exit()
{
    int i;
    
    for (i = 0; i < K; i++)
        HP[K * sd.thread_index + i].p = NULL;
    
    printf("mr_thread_exit: rlist size %d, reclaimed_count %d\n", sd.rlist->size, reclaimed_count);
    while (sd.rcount > 0) {
        scan();
        sched_yield();
    }
}

void mr_reinitialize()
{
}

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
  return ( *(uint64_t*)a - *(uint64_t*)b );
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

void scan()
{
    /* Iteratation variables. */
    mr_node_t *cur;
    int i;

    /* List of SMR callbacks. */
    double_llist_t tmplist;
    init(&tmplist);

    /* List of hazard pointers, and its size. */
    void **plist = sd.plist;
    size_t psize;

    /*
     * Make sure that the most recent node to be deleted has been unlinked
     * in all processors' views.
     *
     * Good:
     *   A -> B -> C ---> A -> C ---> A -> C
     *                    B -> C      B -> POISON
     *
     * Illegal:
     *   A -> B -> C ---> A -> B      ---> A -> C
     *                    B -> POISON      B -> POISON
     */
    //write_barrier();
    MEM_BARRIER;

    /* Stage 1: Scan HP list and insert non-null values in plist. */
    psize = 0;
    for (i = 0; i < H; i++) {
      if (HP[i].p != NULL) {
        plist[psize] = HP[i].p;
        psize++;
      }
    }

    
    /* Stage 2: Sort the plist. */
    /* OANA For now, just do linear search*/
    //qsort(plist, psize, sizeof(void *), compare);

    /* Stage 3: Free non-harzardous nodes. */
    sd.rcount = 0;

    tmplist.head = sd.rlist->head;
    tmplist.tail = sd.rlist->tail;
    tmplist.size = sd.rlist->size;

    init(sd.rlist);

    // Setting rcount to 0 here would ignore nodes from rlist
    while (tmplist.size > 0) {
        /* Pop cur off top of tmplist. */
        cur = remove_from_tail(&tmplist);
        /*OANA here, bsearch was used, with the compar function*/
        if (ssearch(plist, psize, cur->actual_node)) {
            add_to_head(sd.rlist, cur);
            sd.rcount++;
        } else {
            ((node_t *)(cur->actual_node))->key = 10000;
            ssfree_alloc(0, cur->actual_node);
            ssfree_alloc(1, cur);
        }
    }
}

void free_node_later(void *n)
{
    if (n != NULL){

        mr_node_t* wrapper_node = ssalloc_alloc(1, sizeof(mr_node_t));
        wrapper_node->actual_node = n;
        // Create timestamp in mr node
        gettimeofday(&(wrapper_node->created), NULL);

        if (sd.rlist->size <= H){
          ((node_t*)(wrapper_node->actual_node))->marked = 1;
        } else{
          ((node_t*)(wrapper_node->actual_node))->marked = 0;
        }

        //Add to rlist
        add_to_head(sd.rlist, wrapper_node);
        sd.rcount++;


    }

    //If rlist size > 2*#HP do one rotation
    if (sd.rlist->size > H) { // >=?
        rotation();
    } 

}

void rotation(){

  //printf("rotation: rlist size %d\n", sd.rlist->size);

  //verify current HP and mark corresponding node
  node_t* cur_HP_node = (node_t*)(HP[HP_cur].p);

  if (cur_HP_node != NULL) {
    cur_HP_node->marked = 1;
  }

  //increase HP current counter (mod H)
  HP_cur = (HP_cur + 1) % H;

  //check if tail of rlist is marked
  node_t* rlist_tail = (node_t*)sd.rlist->tail->actual_node;
  if (rlist_tail->marked == 1) {  //if tail is marked
    //unmark it
    rlist_tail->marked = 0;
    //remove it from rlist tail
    //add it to rlist head
    mr_node_t* rlist_tail_mr = remove_from_tail(sd.rlist);
    add_to_head(sd.rlist, rlist_tail_mr);
    
  } else { //tail is unmarked
    //free the memory
    mr_node_t* rlist_tail_mr = remove_from_tail(sd.rlist);
    ((node_t *)(rlist_tail_mr->actual_node))->key = 10000;
    ssfree_alloc(0, rlist_tail_mr->actual_node);
    ssfree_alloc(1, rlist_tail_mr);
    
    //decrease rcount
    reclaimed_count++;
    sd.rcount--;
  }
    
}