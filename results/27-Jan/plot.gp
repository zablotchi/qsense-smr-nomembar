set term pdf dashed linewidth 4
set key below right

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 


infile="./comparison"
set output infile.".pdf"

set title "Updates = 0%"

plot    infile i 0 using 1:2 title "smr" with linespoint ls 2, \
        infile i 0 using 1:5 title "smr-no-membar" with linespoint ls 3, \
        infile i 0 using 1:8 title "smr-igor0" with linespoint ls 4, \
        infile i 0 using 1:11 title "smr-igor1" with linespoint ls 5, \
        infile i 0 using 1:14 title "smr-igor2" with linespoint ls 7, \

set title "Updates = 10%"

plot    infile i 1 using 1:2 title "smr" with linespoint ls 2, \
        infile i 1 using 1:5 title "smr-no-membar" with linespoint ls 3, \
        infile i 1 using 1:8 title "smr-igor0" with linespoint ls 4, \
        infile i 1 using 1:11 title "smr-igor1" with linespoint ls 5, \
        infile i 1 using 1:14 title "smr-igor2" with linespoint ls 7, \


set title "Updates = 50%"                                

plot    infile i 2 using 1:2 title "original" with linespoint ls 2, \
        infile i 2 using 1:3 title "no membar" with linespoint ls 3, \
        infile i 2 using 1:4 title "nmb + ordered rlist" with linespoint ls 4, \
        infile i 2 using 1:5 title "nmb + ordered rlist + periodic_op" with linespoint ls 5, \
        infile i 2 using 1:6 title "nmb + ordered rlist + periodic_time" with linespoint ls 7, \
        infile i 2 using 1:7 title "nmb + ordered rlist + bloom" with linespoint ls 8

set title "Updates = 100%"                                

plot    infile i 3 using 1:2 title "original" with linespoint ls 2, \
        infile i 3 using 1:3 title "no membar" with linespoint ls 3, \
        infile i 3 using 1:4 title "nmb + ordered rlist" with linespoint ls 4, \
        infile i 3 using 1:5 title "nmb + ordered rlist + periodic_op" with linespoint ls 5, \
        infile i 3 using 1:6 title "nmb + ordered rlist + periodic_time" with linespoint ls 7, \
        infile i 3 using 1:7 title "nmb + ordered rlist + bloom" with linespoint ls 8

unset output