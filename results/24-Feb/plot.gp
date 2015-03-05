set term postscript eps dash enhanced "ACaslonPro-Regular,12"
set grid
set xtics nomirror
set ytics nomirror
set border 3 linewidth 2
set format y "%.1t*10^{%T}"

set style line 1 lt 1 lc 1  pt 4   lw 7
set style line 2 lt 2 lc 2  pt 6   lw 7
set style line 3 lt 3 lc 3  pt 8   lw 7
set style line 4 lt 4 lc 4  pt 10  lw 7
set style line 5 lt 5 lc 5  pt 12  lw 7
set style line 6 lt 6 lc 7  pt 14  lw 7
set style line 7 lt 7 lc 8  pt 1   lw 7
set style line 8 lt 8 lc 9  pt 2   lw 7
set style line 9 lt 9 lc 10 pt 3   lw 7

set xlabel "Threads"
set ylabel "Throughput (ops/s)"

## PRINT KEY FOR FIRST SET OF PLOTS ##

set output "./plots_igor/scalability/key.eps"
set key below right
set termoption font "Times,12"
plot 0 with linespoint ls 1 title "smr",\
     0 with linespoint ls 2 title "smr-nomembar"
set term postscript eps dash enhanced size 5.533 cm, 3.8731 cm "ACaslonPro-Regular,12" 
unset key
unset output

## FIRST SET OF PLOTS ##

do for [size in "200 2K 20K"] {
do for [machine in "xeon opteron"] {
block=0
do for [u in "0 10 50 100"] {

set output "./plots_igor/scalability/".machine."_scalability_".size."_".u.".eps"

infile="./".machine."-scalability-list-size-".size

plot \
infile i block using 1:4 with linespoint ls 1 title "smr",\
infile i block using 1:5 with linespoint ls 2 title "smr-nomembar"

unset output

block = block + 1
}
}
}

## PRINT KEY FOR SECOND SET OF PLOTS ##

set output "./plots_igor/scalability-opts/key.eps"
set key below right
set termoption font "Times,12"
plot \
0 with linespoint ls 1  title "smr",\
0 with linespoint ls 2  title "smr-no-membar",\
0 with linespoint ls 3  title "opts-b",\
0 with linespoint ls 4  title "opts-p",\
0 with linespoint ls 5  title "opts-p+b",\
0 with linespoint ls 6  title "opts-r",\
0 with linespoint ls 7  title "opts-r+b",\
0 with linespoint ls 8  title "opts-r+p",\
0 with linespoint ls 9  title "opts-r+p+b"

set termoption font "ACaslonPro-Regular,12"
set term postscript eps dash enhanced "ACaslonPro-Regular,12" size 5.533 cm, 3.8731 cm
unset key
unset output

## SECOND SET OF PLOTS ##

do for [size in "200 2K 20K"] {
do for [machine in "opteron"] {
block=0
do for [u in "0 10 50 100"] {

set output "./plots_igor/scalability-opts/".machine."_opts_scalability_".size."_".u.".eps"

infile="./".machine."-opts-scalability-".size

plot \
infile i block using 1:2  with linespoint ls 1  title "smr",\
infile i block using 1:3  with linespoint ls 2  title "smr-no-membar",\
infile i block using 1:5  with linespoint ls 3  title "opts-b",\
infile i block using 1:6  with linespoint ls 4  title "opts-p",\
infile i block using 1:7  with linespoint ls 5  title "opts-p+b",\
infile i block using 1:8  with linespoint ls 6  title "opts-r",\
infile i block using 1:9  with linespoint ls 7  title "opts-r+b",\
infile i block using 1:10 with linespoint ls 8  title "opts-r+p",\
infile i block using 1:11 with linespoint ls 9  title "opts-r+p+b"

unset output

block = block + 1
}
}
}

unset grid

##### HYBRID (NOT LAZY) #####

do for [machine in "xeon opteron"] {
do for [u in "10 50"] {

set output "./plots_oana/".machine."_time_hybrid_".u.".eps"

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

set output "./plots_oana/".machine."_time_hybrid_lazy_".u.".eps"

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

set output "./plots_oana/".machine."_time_hybrid_lazy_rcount".u.".eps"

infile="./".machine."-time-hybrid-lazy-u".u

plot \
infile i 0 using 1:3 with lines ls 1 lw 5 title "hybrid",\
infile i 3 using 1:3 with lines ls 6 lw 5 title "hybrid-lazy"

unset output

}
}

## OPTIMIZATION RESULTS
set term postscript eps dash enhanced "ACaslonPro-Regular" 12 size 9.5 cm, 6.65 cm
set style data histogram
set style histogram clustered
set style fill pattern
set termoption solid
set format y
set border linewidth 1
set key above
set logscale y

set xlabel "Update percent"
infile="./opts-effects"

set ylabel "Nodes freed per scan call"
set output "./plots_igor/opts-effects/nodes_freed.eps"
plot for [COL=2:9] infile i 0 using COL:xtic(1) title col
unset output
unset logscale


set ylabel "Nodes scanned per scan call"
set output "./plots_igor/opts-effects/nodes_scanned.eps"
plot for [COL=2:9] infile i 1 using COL:xtic(1) title col
unset output

set ylabel "Time spent searching (us)"
set output "./plots_igor/opts-effects/time_spent.eps"
plot for [COL=2:9] infile i 2 using COL:xtic(1) title col
unset output