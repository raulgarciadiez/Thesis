set log
#unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Rel. Std. Deviation' offset 2,-1
set autoscale
set xrange [0.05:1]
set yrange [2.e-2:1.e0]

#set key spacing 1.5
#set key 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

p 'isoscattering_curve.dat' w l ls 1 t 'Background subtracted', 'isoscattering_curve_raw.dat' w l ls 2 t 'Raw data'
