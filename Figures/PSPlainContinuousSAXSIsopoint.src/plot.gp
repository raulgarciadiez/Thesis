set logscale xy
set grid
set xlabel '$q$ / nm$^{-1}$' offset 0,0.6
set ylabel 'Rel. Std. Deviation' offset 3.7,0.3
set autoscale
set yrange [0.05:0.8]
set xrange [0.05:0.25]
set ytics (0.05,0.1,0.2,0.4,0.8)
set xtics (0.05,0.1,0.2)
unset key
p 'isoscattering_curve.dat' u 1:2 w l ls 1 notitle, 'isoscattering_curve_RAW.dat' u 1:2 w l ls 2 notitle