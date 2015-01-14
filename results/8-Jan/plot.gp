set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./hybrid-100s"
set output infile.".pdf"
set title "Time evolution with periodic thread interruption"
set yrange [2000000 < *:*]

plot infile using 1:2 title "hybrid-int-64" with linespoint ls 2,\
	 infile using 1:3 title "hybrid-no-int-64" with linespoint ls 3, \
	 infile using 1:4 title "smr-first-128" with linespoint ls 4,\
	 infile using 1:5 title "qsbr-first-128" with linespoint ls 5,\
	 infile using 1:6 title "hybrid-no-int-128" with linespoint ls 6	

unset output