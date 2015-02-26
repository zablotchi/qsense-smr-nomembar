set term pdf enhanced
set termoption dash
set key below right
set grid
set xtics nomirror
set ytics nomirror
set border 3 linewidth 4
set format y "%.1t*10^{%T}"

set style line 1 lt 1 lc rgb "orange"   pt 4  lw 5 
set style line 2 lt 2 lc rgb "blue"    pt 6  lw 5
set style line 3 lt 3 lc rgb "green"   pt 8  lw 5
set style line 4 lt 4 lc rgb "red"     pt 12 lw 5
set style line 5 lt 6 lc rgb "magenta" pt 7  lw 5
set style line 6 lt 5 lc rgb "cyan"    pt 3  lw 5

set xlabel "Threads"
set ylabel "Throughput (ops/s)" 

do for [size in "200 2K 20K"] {
do for [machine in "xeon opteron"] {
block=0
do for [u in "0 10 50 100"] {

set output "./plots_igor/".machine."_scalability_".size."_".u.".pdf"

infile="./".machine."-scalability-list-size-".size

plot \
infile i block using 1:2 with linespoint ls 1 title "hybrid",\
infile i block using 1:3 with linespoint ls 2 title "qsbr",\
infile i block using 1:4 with linespoint ls 3 title "smr",\
infile i block using 1:5 with linespoint ls 4 title "smr-nomembar",\
infile i block using 1:8 with linespoint ls 5 title "harris-opt",\
infile i block using 1:7 with linespoint ls 6 title "hybrid-lazy"

unset output

block = block + 1
}
}
}

unset grid

##### HYBRID (NOT LAZY) #####

do for [machine in "xeon opteron"] {
do for [u in "10 50"] {

set output "./plots_oana/".machine."_time_hybrid_".u.".pdf"

infile="./".machine."-time-hybrid-u".u

plot \
infile i 0 using 1:2 with lines ls 1 lw 5 title "hybrid",\
infile i 1 using 1:2 with lines ls 2 lw 5 title "qsbr",\
infile i 2 using 1:2 with lines ls 4 lw 5 title "smr-nomembar"

unset output

}
}

##### HYBRID LAZY #####

do for [machine in "xeon opteron"] {
do for [u in "10 50"] {

set output "./plots_oana/".machine."_time_hybrid_lazy_".u.".pdf"

infile="./".machine."-time-hybrid-lazy-u".u

plot \
infile i 0 using 1:2 with lines ls 1 lw 5 title "hybrid",\
infile i 1 using 1:2 with lines ls 2 lw 5 title "qsbr",\
infile i 2 using 1:2 with lines ls 4 lw 5 title "smr-nomembar",\
infile i 3 using 1:2 with lines ls 6 lw 5 title "hybrid-lazy"

unset output

}
}

##### HYBRID LAZY RCOUNT #####

do for [machine in "xeon opteron"] {
do for [u in "10 50"] {

set output "./plots_oana/".machine."_time_hybrid_lazy_rcount".u.".pdf"

infile="./".machine."-time-hybrid-lazy-u".u

plot \
infile i 0 using 1:3 with lines ls 1 lw 5 title "hybrid",\
infile i 3 using 1:3 with lines ls 6 lw 5 title "hybrid-lazy"

unset output

}
}