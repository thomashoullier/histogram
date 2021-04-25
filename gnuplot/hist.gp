#!/bin/gnuplot
set terminal svg
set output "hist.svg"

set datafile separator ";"
set style fill solid 0.5

stats "hist.txt" nooutput
N = STATS_records
binsize = (STATS_max_x - STATS_min_x) / (N - 1)

set ylabel "Counts"
set key off

plot "hist.txt" using 1:2:(binsize) every 1::1::N-2 with boxes,\
     "hist.txt" using 1:2:(binsize) every N-1::0 with boxes lc 2
