set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./time"
set output infile.".pdf"
set title "Periodic thread interruption - 20 threads - 10% updates - Xeon"

plot infile i 0 using 1:2 title "hybrid" with linespoint ls 2,\
	 infile i 0 using 1:3 title "hybrid-lazy" with linespoint ls 3,\


set title "Periodic thread interruption - 20 threads - 100% updates - Xeon"
plot infile i 1 using 1:2 title "hybrid" with linespoint ls 2,\
	 infile i 1 using 1:3 title "hybrid-lazy" with linespoint ls 3,\

unset output