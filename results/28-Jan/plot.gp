set term pdf dashed linewidth 4
set key below right

set xlabel "Time (s)"
set ylabel "Throughput (ops/s)" 


infile="./time.txt"
set output infile.".pdf"

#set title "Updates = 0%"
#
#plot    infile i 0 using 1:2 title "hybrid" with linespoint ls 2, \
#        infile i 3 using 1:2 title "hybrid-lazy" with linespoint ls 3, \

set title "Updates = 10%"

plot    infile i 1 using 1:2 title "hybrid" with linespoint ls 2, \
        infile i 4 using 1:2 title "hybrid-lazy" with linespoint ls 3, \


set title "Updates = 100%"                                

plot    infile i 2 using 1:2 title "hybrid" with linespoint ls 2, \
        infile i 5 using 1:2 title "hybrid-lazy" with linespoint ls 3, \


unset output