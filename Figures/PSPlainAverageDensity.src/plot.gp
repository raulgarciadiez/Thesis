set grid
set xlabel 'Solvent Electron density / nm$^{-3}$'
set ylabel '$I(0)$ / a.u.' offset 1.5
set autoscale
set xrange[334.:345.]
set yrange [-0.2:11]

a=36722668518278.6/1.e14
b=339.211
c=47807032125371.6/1.e14
f(x)=a*(x-b)**2+c

p f(x) ls 2 notitle,  'Guinier-results.dat' u 1:($4/1.e14) w p ls 1 notitle

