N=2.e12
N2=9*N

f(x)=a*(x-b)**2+c
g(x)=d*(x-e)**2+f

b=358.
e=340.

fit f(x) 'HDL_Guinier-results.dat' u 1:($4/N)  via a,b,c
fit g(x) 'LDL_intensity_zero_angle.dat' u 1:($2/N2)  via d,e,f

set grid

set xlabel 'Solvent Electron Density / nm$^{-3}$'
set ylabel '$I(0)$ / a.u.' offset 0

set xrange [333:385]
set yrange [-0.1:2.5]

set key spacing 1.5 samplen 2 width -2 at 378,2.45

p f(x) ls 1 notitle, 'HDL_Guinier-results.dat' u 1:($4/N) w p ls 1 t '\smaller HDL', 'LDL_intensity_zero_angle.dat' u 1:($2/N2) w p ls 2 t '\smaller LDL', g(x) ls 2 notitle

