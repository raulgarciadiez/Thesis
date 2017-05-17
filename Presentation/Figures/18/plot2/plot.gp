reset 
l '../../style.gp'

set size 0.9,1


set xlabel 'Solvent Electron Density / nm^{-3}' 
set ylabel '{/Times-Italic I}(0) / cm^{-1}' offset 1.

set grid

set xrange [342:365]
set yrange [0:125]

f(x)=C+A*(x-B)**2

A=3.4687e13
B=346.39
C=1.637e14

N=(100*1.05e12)
print C/N

p 'Guinier-results.dat' u 1:($4/N) w p ls 1 notitle, f(x)/N ls 2 notitle


set out "plot.eps"
replot
set out
set term pop
! convert -density 600 plot.eps ../plot2.pdf
! convert -density 600 plot.eps ../plot2.png


