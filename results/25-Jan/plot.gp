set term pdf dashed linewidth 4
set key below right

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 


infile="./igoropt_vs_nomembar_vs_lazy_256K"
set output infile.".pdf"

set title "Updates = 0%"

plot    infile i 0 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 0 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 0 using 1:8 title "smr-lazy" with linespoint ls 3, \
        infile i 0 using 1:11 title "smr" with linespoint ls 4, \

set title "Updates = 10%"

plot    infile i 1 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 1 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 1 using 1:8 title "smr-lazy" with linespoint ls 3, \
        infile i 1 using 1:11 title "smr" with linespoint ls 4, \


set title "Updates = 50%"                                

plot    infile i 2 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 2 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 2 using 1:8 title "smr-lazy" with linespoint ls 3, \
        infile i 2 using 1:11 title "smr" with linespoint ls 4, \

set title "Updates = 80%"                                

plot    infile i 3 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 3 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 3 using 1:8 title "smr-lazy" with linespoint ls 3, \
        infile i 3 using 1:11 title "smr" with linespoint ls 4, \

set title "Updates = 100%"                                

plot    infile i 4 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 4 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 4 using 1:8 title "smr-lazy" with linespoint ls 3, \
        infile i 4 using 1:11 title "smr" with linespoint ls 4, \


unset output