set grid
set xlabel 'Polydispersity / $\%$'
set ylabel 'Deviation / $\%$'
set key 15, -5
 
p 'isopoint_polyd_nu_0.689.dat' u 1:(100*($2-1)) w l ls 1 t '68.9 $\%$', 'isopoint_polyd_nu_0.828.dat' u 1:(100*($2-1)) w l ls 2 t '82.8 $\%$',  'isopoint_polyd_nu_0.938.dat' u 1:(100*($2-1)) w l ls 3 t '93.8 $\%$'
