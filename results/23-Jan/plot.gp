set term pdf enhanced dashed
set key below right
set grid
set xtics nomirror
set ytics nomirror
set border 3 linewidth 4
set format y "%.1t*10^{%T}"

set style line 1  lt 1 linecolor rgb "black"   linewidth 8.000 pointtype 12
set style line 2  lt 2 linecolor rgb "blue"    linewidth 8.000 
set style line 3  lt 3 linecolor rgb "green"   linewidth 8.000
set style line 4  lt 4 linecolor rgb "red"     linewidth 8.000
set style line 5  lt 5 linecolor rgb "magenta" linewidth 8.000 
set style line 6  lt 6 linecolor rgb "cyan"    linewidth 8.000 

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 


infile="./igoropt_vs_nomembar_vs_lazy"
set output infile.".pdf"

set title "Updates = 0%"

plot    infile i 0 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 0 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 0 using 1:8 title "smr-lazy" with linespoint ls 3, \

set title "Updates = 10%"

plot    infile i 1 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 1 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 1 using 1:8 title "smr-lazy" with linespoint ls 3, \


set title "Updates = 50%"                                

plot    infile i 2 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 2 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 2 using 1:8 title "smr-lazy" with linespoint ls 3, \

set title "Updates = 80%"                                

plot    infile i 3 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 3 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 3 using 1:8 title "smr-lazy" with linespoint ls 3, \

set title "Updates = 100%"                                

plot    infile i 4 using 1:2 title "smr-no-membar" with linespoint ls 2, \
        infile i 4 using 1:5 title "smr-igor-opt" with linespoint ls 6, \
        infile i 4 using 1:8 title "smr-lazy" with linespoint ls 3, \


unset output