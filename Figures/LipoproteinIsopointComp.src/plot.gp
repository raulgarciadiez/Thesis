set log
set grid

set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Rel. Std. Deviation' offset 1

set xrange [0.3:1.5]
set yrange [6e-2:1.]

set xtics (0.3, 0.5, 1.,1.5)
set ytics (0.1,0.2,0.5,1.)

set key spacing 1.5 samplen 2 width -2

p 'HDL_isoscattering_curve.dat' w l ls 1 t '\smaller HDL', 'LDL_isoscattering_curve.dat' w l ls 2 t '\smaller LDL'
