set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./time-no-block-3"
set output "./time-no-block-3.pdf"
set title "Time evolution with no thread interrupted"

plot infile using 1:2 title "hybrid" with linespoint ls 2,\
	 infile using 1:4 title "qsbr" with linespoint ls 3,\
	 infile using 1:6 title "smr" with linespoint ls 4,\

unset output

infile = "./time-block-3"
set output "./time-block-3.pdf"
set title "Time evolution with one thread interrupted at half time"
set yrange [2000000 < *:*]

plot infile using 1:2 title "hybrid" with linespoint ls 2,\
	 infile using 1:4 title "qsbr" with linespoint ls 3,\
	 infile using 1:6 title "smr" with linespoint ls 4,\

unset output