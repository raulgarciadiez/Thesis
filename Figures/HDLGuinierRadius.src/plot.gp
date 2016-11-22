set grid
set xrange [ 334 : 386 ] #noreverse nowriteback
set yrange [ -10 : 300 ] #noreverse nowriteback

set xlabel 'Solvent Electron Density / nm$^{-3}$'
set ylabel 'Radius$^2$ / nm$^{2}$' offset 1
f(x)=R0+alpha/(x-rho)
R0 = 35.4427683594868
alpha = -624.072672144622
rho = 353.638119019802

p  f(x) ls 2 not, 'Sphere_HDL_results_edit.dat' u 8:($1**2):(-3e2*$5) w e ls 1 not
## fit f(x) 'Sphere_HDL_results_edit.txt' u 8:($1**2):(-1e3*$5) via R0, rho, alpha
#    EOF
