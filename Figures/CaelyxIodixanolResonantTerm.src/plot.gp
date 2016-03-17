set log
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Shape Factor / a.u.' offset 2
set autoscale
set xrange [0.025:.3]
set yrange [1:1e4]

set key spacing 5

set xtics (0.02,0.05,0.1,0.2,0.3)

p 'sphere_resonant_term_AutoSAXS_fitresults.dat' every 3 u 1:($2/1.e15):($4/1.e15) w yerrorbars ls 1 t 'Experimental Data','' u 1:($2/1.e15) every 3 w p ls 1 notitle, '' u 1:($3/1.e15) w l ls 2 t 'Sphere Fit'
