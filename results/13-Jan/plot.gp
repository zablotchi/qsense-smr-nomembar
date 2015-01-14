set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./comparison4"
set output infile.".pdf"
set title "Time evolution with periodic thread interruption"
set yrange [1e6 < *:*]

plot infile using 1:2 title "hybrid" with linespoint ls 2,\
	 infile using 1:3 title "qsbr" with linespoint ls 3,\
	 infile using 1:4 title "smr" with linespoint ls 4

unset output

set xlabel "Threads"

infile = "./scalability"
set output infile.".pdf"
set title "Scalability: u=10%, d=1s, i=1024"

plot infile using 1:2 title "hybrid" with linespoint ls 2,\
	 infile using 1:5 title "qsbr" with linespoint ls 3,\
	 infile using 1:8 title "smr" with linespoint ls 4

unset output