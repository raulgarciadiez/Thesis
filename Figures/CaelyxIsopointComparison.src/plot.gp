set xlabel '$q$ / nm$^{-1}$' offset 0,0.3
set ylabel 'Relative Standard Deviation' offset 1

set autoscale
set grid
set xrange [0.095:0.275]
set xtics 0.05

set key spacing 1.5 samplen 2 width -5

p 'isoscattering_curve_iodixanol.dat' u 1:2 w l ls 1 t '\smaller Aqueous iodixanol', 'isoscattering_curve_sucrose.dat' u 1:2 w l ls 2 t '\smaller Aqueous sucrose'

