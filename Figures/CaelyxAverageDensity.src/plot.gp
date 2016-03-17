set xlabel 'Solvent Electron Density / nm$^{-3}$' 
set ylabel '$I(0)$ / cm$^{-1}$'

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
