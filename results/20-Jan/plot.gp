set term pdf dashed linewidth 4
set key below right

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 


infile="./scalability"
set output infile.".pdf"

set title "Updates = 0%"

plot    infile i 0 using 1:5 title "qsbr" with linespoint ls 2, \
        infile i 0 using 1:2 title "hybrid" with linespoint ls 6, \
        infile i 0 using 1:11 title "smr no membar opt" with linespoint ls 7, \
        infile i 0 using 1:14 title "smr lazy" with linespoint ls 3, \
        infile i 0 using 1:8 title "smr no membar" with linespoint ls 4, \
        infile i 0 using 1:17 title "smr" with linespoint ls 5

set title "Updates = 10%"

plot    infile i 1 using 1:5 title "qsbr" with linespoint ls 2, \
        infile i 1 using 1:2 title "hybrid" with linespoint ls 6, \
        infile i 1 using 1:11 title "smr no membar opt" with linespoint ls 7, \
        infile i 1 using 1:14 title "smr lazy" with linespoint ls 3, \
        infile i 1 using 1:8 title "smr no membar" with linespoint ls 4, \
        infile i 1 using 1:17 title "smr" with linespoint ls 5

set title "Updates = 100%"                                

plot    infile i 2 using 1:5 title "qsbr" with linespoint ls 2, \
        infile i 2 using 1:2 title "hybrid" with linespoint ls 6, \
        infile i 2 using 1:11 title "smr no membar opt" with linespoint ls 7, \
        infile i 2 using 1:14 title "smr lazy" with linespoint ls 3, \
        infile i 2 using 1:8 title "smr no membar" with linespoint ls 4, \
        infile i 2 using 1:17 title "smr" with linespoint ls 5

unset output