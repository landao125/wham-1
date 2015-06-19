#!/usr/bin/env gnuplot



set encoding cp1250 # make the minus sign longer
set terminal push
set terminal postscript eps enhanced size 5, 3.5 font "Times, 24"
set output "whamcmp.eps"



BOLTZ = 1.380658*6.0221367/1000

set xlabel "{/Times-Italic T_i} (K)" offset 1, 1
set xtics 50 font "Times,20" offset 0, 0.5
set mxtics 5

set logscale y
set format y "10^{%T}"
set ytics font "Times,20" offset 0.5, 0
set mytics 20
set ylabel "{/=32 |} {/Times-Italic f_i} - {/Times-Italic f}@_i^{/=16 &{i}(MBAR)} {/=32 |}" offset 1.0, 1.0

set key at 420, 1e-6 Left reverse font "Times,20" width -5 vertical maxrows 5 spacing 1.0

color1  = "#4466aa"
color2  = "#cc6666"

color9  = "#000000"

set style line 1  lw 2.0 lt 4 lc rgb color1  pt 8   ps 2.0
set style line 2  lw 2.0 lt 4 lc rgb color1  pt 6   ps 1.8
set style line 3  lw 2.0 lt 4 lc rgb color1  pt 4   ps 1.6
set style line 4  lw 2.0 lt 4 lc rgb color1  pt 12  ps 2.0

set style line 11 lw 2.0 lt 4 lc rgb color2  pt 9   ps 2.0
set style line 12 lw 2.0 lt 4 lc rgb color2  pt 7   ps 1.8
set style line 13 lw 2.0 lt 4 lc rgb color2  pt 5   ps 1.6
set style line 14 lw 2.0 lt 4 lc rgb color2  pt 13  ps 2.0

set style line 9  lw 2.0 lt 1 lc rgb color9  pt 1   ps 1.0

plot [300:420][5e-9:2e2] \
  "../../data/1VII/stwham_de1.out"    u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 11  t "ST-WHAM, {/Symbol D}{/Times-Italic E} = 1.0", \
  "../../data/1VII/stwham_de10.out"   u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 12  t "ST-WHAM, {/Symbol D}{/Times-Italic E} = 10.0", \
  "../../data/1VII/stwham_de100.out"  u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 13  t "ST-WHAM, {/Symbol D}{/Times-Italic E} = 100.0", \
  "../../data/1VII/wham_de1.out"      u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 1   t "WHAM, {/Symbol D}{/Times-Italic E} = 1.0", \
  "../../data/1VII/wham_de10.out"     u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 2   t "WHAM, {/Symbol D}{/Times-Italic E} = 10.0", \
  "../../data/1VII/wham_de100.out"    u (1/BOLTZ/$2):(($1 > 0) ? abs($7-$3) : 1/0) w lp ls 3   t "WHAM, {/Symbol D}{/Times-Italic E} = 100.0", \



unset output
set terminal pop
reset