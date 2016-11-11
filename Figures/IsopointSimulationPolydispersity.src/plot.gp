set grid
set xlabel 'Polydispersity degree / $\%$'
set ylabel 'Isoscattering point deviation / $\%$'

set key title 'Ratio $\sfrac{R_{\text{core}}}{R}$'
set key spacing 1.5 samplen 2 at 9.3,-3.7 width -5
#set key box linestyle 4 lw 1

set ytics (-7,-5,-3,-1,0,1,3)
 
p 'isopoint_polyd_nu_0.689.dat' u 1:(100*($2-1)) w l ls 1 t '\smaller 69 $\%$', 'isopoint_polyd_nu_0.828.dat' u 1:(100*($2-1)) w l ls 2 t '\smaller 83 $\%$',  'isopoint_polyd_nu_0.938.dat' u 1:(100*($2-1)) w l ls 3 t '\smaller 94 $\%$'
