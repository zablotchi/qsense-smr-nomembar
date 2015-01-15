set term pdf dashed linewidth 4

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)"

set key below right

infile = "./callbacks"
set output infile.".pdf"
set title "Time evolution with periodic thread interruption"
#set yrange [*: *]

plot infile using 1:2 title "n20t" with linespoint ls 2 axes x1y1,\
	 infile using 1:7 title "n16t" with linespoint ls 3 axes x1y1,\
	 infile using 1:6 title "n20c" with linespoint ls 4 axes x1y2,\
	 infile using 1:9 title "n16c" with linespoint ls 5 axes x1y2,\

unset output