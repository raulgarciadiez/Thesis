set log
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Scattering Intensity / a.u.'offset 2
set autoscale
set xrange [0.23:7.4]
set yrange [0.45:2.2e2]
set xtics (0.3,0.5,1, 3, 5)

N=1.e16


#unset key 

p 'hdlfit.dat' u 1:($2/N) w p ls 1 t 'Experimental', '' u 1:($3/N) w l ls 2 t 'Model Fit'


