set logscale y
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Relative Standard Deviation' offset 2
set autoscale
set xrange [0.06:.17]
set yrange [0.04:1.1]
set key spacing 1.5 samplen 2 width -3

set xtics (0.075,0.1,0.125,0.15)


p 'standard_deviation-2-datasets.dat' u 1:($2) w l ls 1 t '\smaller Plain PS-COOH', 'isoscattering_curve.dat' u 1:($2) w l ls 2 t '\smaller After attaching IgG'
