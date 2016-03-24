set logscale y
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Relative Standard Deviation' offset 2
set autoscale
set xrange [0.06:.17]
set yrange [0.04:1.1]
set key font "Times,24"
set key spacing 5

set xtics (0.075,0.1,0.125,0.15)

#set format y "10^{%T}"

p 'standard_deviation-2-datasets.dat' u 1:($2) w l ls 1 t 'Plain PS-COOH', 'isoscattering_curve.dat' u 1:($2) w l ls 2 t 'After attaching IgG'
