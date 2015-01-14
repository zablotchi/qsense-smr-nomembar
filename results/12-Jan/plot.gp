set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./48core-n16-comp"
set output infile.".pdf"
set title "Time evolution with periodic thread interruption - 16 threads - opteron"
set yrange [*: 4e6]

plot infile using 1:2 title "no-int" with linespoint ls 2,\
	 infile using 1:4 title "int" with linespoint ls 3,\


unset output