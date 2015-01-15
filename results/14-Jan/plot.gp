set term pdf dashed linewidth 4
set key below right

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 


infile="./history-comparison"
set output infile.".pdf"

set title "3 Nov; Updates = 10%"
plot infile index 0 using 1:2  title "qsbr" with linespoint ls 2, \
     infile index 0 using 1:8  title "smr no membar" with linespoint ls 4

set title "18 Nov; Updates = 10%"

plot infile index 1 using 1:2  title "qsbr" with linespoint ls 2, \
     infile index 1 using 1:5  title "smr no membar" with linespoint ls 4

set title "18 Nov; Updates = 100%"                                

plot infile index 2 using 1:2  title "qsbr" with linespoint ls 2, \
     infile index 2 using 1:5  title "smr no membar" with linespoint ls 4

set title "14 Jan; Updates = 10%"                                

plot infile index 3 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 3 using 1:8  title "smr no membar" with linespoint ls 4,\
     infile index 3 using 1:2  title "hybrid" with linespoint ls 3

unset output

infile="./core_comparison"
set output infile.".pdf"

set title "14 Jan; Normal scaling; Updates = 10%"
plot infile index 0 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 0 using 1:8  title "smr no membar" with linespoint ls 4

set title "14 Jan; Hyperthreads-first scaling; Updates = 10%"

plot infile index 1 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 1 using 1:8  title "smr no membar" with linespoint ls 4

set title "14 Jan; Alternating scaling; Updates = 10%"                                

plot infile index 2 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 2 using 1:8  title "smr no membar" with linespoint ls 4

unset output

infile="./xeon-comparison"
set output infile.".pdf"

set title "Xeon; Updates = 0%; Initial = 2048"

plot infile index 0 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 0 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 0 using 1:8  title "smr no membar" with linespoint ls 4

set title "Xeon; Updates = 10%; Initial = 2048"

plot infile index 1 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 1 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 1 using 1:8  title "smr no membar" with linespoint ls 4

set title "Xeon; Updates = 100%; Initial = 2048"

plot infile index 2 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 2 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 2 using 1:8  title "smr no membar" with linespoint ls 4


unset output

infile="./opteron-comparison"
set output infile.".pdf"

set title "Opteron; Updates = 0%; Initial = 2048"

plot infile index 0 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 0 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 0 using 1:8  title "smr no membar" with linespoint ls 4

set title "Opteron; Updates = 10%; Initial = 2048"

plot infile index 1 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 1 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 1 using 1:8  title "smr no membar" with linespoint ls 4

set title "Opteron; Updates = 100%; Initial = 2048"

plot infile index 2 using 1:2  title "hybrid" with linespoint ls 3, \
     infile index 2 using 1:5  title "qsbr" with linespoint ls 2, \
     infile index 2 using 1:8  title "smr no membar" with linespoint ls 4


unset output