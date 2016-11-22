set xlabel 'Solvent electron density / nm$^{-3}$' 
set ylabel '$I(0)$ / a.u.' offset 1.5

set grid

f(x)=A*(x-B)**2

A=5.98984567e-03   
B=3.46040861e+02

unset key 

set yrange [-0.06:1.5]
set xrange [333:361]

p f(x) ls 2, 'guinier-radius-results.dat' u 1:($4/1e25) w p ls 1
