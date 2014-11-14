#!/bin/bash

elem=$1;
shift;

source scripts/lock_exec;
source scripts/config;

prog1="$1";
shift;
prog2="$1";
shift;
prog3="$1";
shift;
params="$@";


printf "#       %-32s%-32s%-32s\n" "$prog1" "$prog2" "$prog3";
echo "#elem  throughput  %linear scalability throughput  %linear scalability throughput  %linear scalability"

prog=$prog1;

printf "%-8d" 1;
thr1a=$($run_script ./$prog $params -i1 -r2 | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
printf "%-12d" $thr1a;
printf "%-8.2f" 100.00;
printf "%-12d" 1;

prog=$prog2;

thr1b=$($run_script ./$prog $params -i1 -r2 | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
printf "%-12d" $thr1b;
printf "%-8.2f" 100.00;
printf "%-12d" 1;

prog=$prog3;

thr1c=$($run_script ./$prog $params -i1 -r2 | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
printf "%-12d" $thr1c;
printf "%-8.2f" 100.00;
printf "%-8d\n" 1;


for i in $elem
do
    if [ $i -eq 1 ]
    then
	continue;
    fi;

    printf "%-8d" $i;

    prog=$prog1;
    thr1=$thr1a;

    r=`expr $i \* 2`

    thr=$($run_script ./$prog $params -i$i -r$r | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
    printf "%-12d" $thr;
    scl=$(echo "$thr/$thr1" | bc -l);
    linear_p=$(echo "100*(1-(($i-$scl)/$i))" | bc -l);
    printf "%-8.2f" $linear_p;
    printf "%-12.2f" $scl;

    prog=$prog2;
    thr1=$thr1b;

    thr=$($run_script ./$prog $params -i$i -r$r | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
    printf "%-12d" $thr;
    scl=$(echo "$thr/$thr1" | bc -l);
    linear_p=$(echo "100*(1-(($i-$scl)/$i))" | bc -l);
    printf "%-8.2f" $linear_p;
    printf "%-12.2f" $scl;

    prog=$prog3;
    thr1=$thr1c;

    thr=$($run_script ./$prog $params -i$i -r$r | grep "#txs" | cut -d'(' -f2 | cut -d. -f1);
    printf "%-12d" $thr;
    scl=$(echo "$thr/$thr1" | bc -l);
    linear_p=$(echo "100*(1-(($i-$scl)/$i))" | bc -l);
    printf "%-8.2f" $linear_p;
    printf "%-8.2f\n" $scl;


done;

source scripts/unlock_exec;
