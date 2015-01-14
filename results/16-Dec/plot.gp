set term pdf dashed linewidth 4
set key below right


infile="./compare6-u0"
set output "./compare6.pdf"


set title "Updates = 0%"
plot    infile using 1:2 title "qsbr" with linespoint ls 2, \
        infile using 1:5 title "hybrid" with linespoint ls 6, \
        infile using 1:8 title "smr no membar opt" with linespoint ls 7, \
        infile using 1:14 title "smr lazy" with linespoint ls 3, \
        infile using 1:11 title "smr no membar" with linespoint ls 4, \
        infile using 1:17 title "smr" with linespoint ls 5

infile="./compare6-u10"
set title "Updates = 10%"

plot    infile using 1:2 title "qsbr" with linespoint ls 2, \
        infile using 1:5 title "hybrid" with linespoint ls 6, \
        infile using 1:8 title "smr no membar opt" with linespoint ls 7, \
        infile using 1:14 title "smr lazy" with linespoint ls 3, \
        infile using 1:11 title "smr no membar" with linespoint ls 4, \
        infile using 1:17 title "smr" with linespoint ls 5

infile="./compare6-u100"
set title "Updates = 100%"                                

plot    infile using 1:2 title "qsbr" with linespoint ls 2, \
        infile using 1:5 title "hybrid" with linespoint ls 6, \
        infile using 1:8 title "smr no membar opt" with linespoint ls 7, \
        infile using 1:14 title "smr lazy" with linespoint ls 3, \
        infile using 1:11 title "smr no membar" with linespoint ls 4, \
        infile using 1:17 title "smr" with linespoint ls 5

unset output
