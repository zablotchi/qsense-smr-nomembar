ROOT = ../..

include $(ROOT)/common/Makefile.common

# Optimizations are enabled using IGOR_OPT_LEVEL which
# is coded on a 3-bit integer: lowest bit enables bloom, 
# second bit enables periodic_op scan, highest bit enables
# only looking at old enough nodes
ifeq ($(IGOR_OPT_LEVEL),0)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt0
endif 
ifeq ($(IGOR_OPT_LEVEL),1)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt1
endif 
ifeq ($(IGOR_OPT_LEVEL),2)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt2
endif
ifeq ($(IGOR_OPT_LEVEL),3)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt3
endif
ifeq ($(IGOR_OPT_LEVEL),4)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt4
endif 
ifeq ($(IGOR_OPT_LEVEL),5)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt5
endif 
ifeq ($(IGOR_OPT_LEVEL),6)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt6
endif
ifeq ($(IGOR_OPT_LEVEL),7)
BINS = $(BINDIR)/lf-ll_smr_no_membar_igor_opt7
endif

PROF = $(ROOT)/src

.PHONY:	all clean

all:	main

LIST_IMPL = harris_opt

measurements.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/measurements.o $(PROF)/measurements.c

ssalloc.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/ssalloc.o $(PROF)/ssalloc.c

sleeper_threads.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/sleeper_threads.o $(PROF)/sleeper_threads.c

murmurhash.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/MurmurHash2.o $(PROF)/MurmurHash2.c

bloom.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/bloom.o $(PROF)/bloom.c

double_llist.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/double_llist.o $(PROF)/double_llist.c	

smr_no_membar_opt.o:
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/smr_no_membar_opt.o $(PROF)/smr_no_membar_opt.c

linkedlist.o: 
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/linkedlist.o linkedlist.c

harris.o: linkedlist.h linkedlist.o smr_no_membar_opt.o
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/harris.o $(LIST_IMPL).c

intset.o: linkedlist.h harris.h
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/intset.o intset.c

test.o: linkedlist.h harris.h intset.h
	$(CC) $(CFLAGS) -c -o $(BUILDIR)/test.o $(TEST_FILE)

main: measurements.o ssalloc.o double_llist.o linkedlist.o harris.o harris.o intset.o test.o smr_no_membar_opt.o sleeper_threads.o murmurhash.o bloom.o $(TMILB)
	$(CC) $(CFLAGS) $(BUILDIR)/measurements.o $(BUILDIR)/ssalloc.o $(BUILDIR)/double_llist.o $(BUILDIR)/linkedlist.o $(BUILDIR)/harris.o $(BUILDIR)/intset.o $(BUILDIR)/test.o $(BUILDIR)/smr_no_membar_opt.o $(BUILDIR)/sleeper_threads.o $(BUILDIR)/MurmurHash2.o $(BUILDIR)/bloom.o -o $(BINS) $(LDFLAGS)

clean:
	-rm -f $(BINS)
