set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./nthreads-comparison"
set output infile.".pdf"
set title "Time evolution with periodic thread interruption"
set yrange [*: 4e6]

plot infile using 1:2 title "n2" with linespoint ls 2,\
	 infile using 1:4 title "n4" with linespoint ls 3,\
	 infile using 1:6 title "n8" with linespoint ls 4,\
	 infile using 1:8 title "n16" with linespoint ls 5,\
	 infile using 1:10 title "n20" with linespoint ls 6,\
	 infile using 1:12 title "n40" with linespoint ls 7\

set yrange [*:*]
plot infile using 1:(($3)/2.0) title "n2" with linespoint ls 2,\
	 infile using 1:(($5)/4.0) title "n4" with linespoint ls 3,\
	 infile using 1:(($7)/8.0) title "n8" with linespoint ls 4,\
	 infile using 1:(($9)/16.0) title "n16" with linespoint ls 5,\
	 infile using 1:(($11)/20.0) title "n20" with linespoint ls 6,\
	 infile using 1:(($13)/40.0) title "n40" with linespoint ls 7

unset output