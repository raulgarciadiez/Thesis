#set terminal epslatex size 15cm,12cm
#

set logscale xy
set grid
set xlabel '$q$ / nm$^{-1}$' offset 0,0.6
set ylabel 'Rel. Std. Deviation' offset 3.7,0.3
set autoscale
set yrange [0.02:1]
set xrange [0.05:0.25]
set ytics (0.02,0.05,0.1,0.2,0.5,1.)
set xtics (0.05,0.1,0.2)
#set key

set label '$I_1$' at 0.07,0.08
set label '$I_2$' at 0.12,0.08
set label '$I_3$' at 0.17,0.08
set label '$I_4$' at 0.2,0.08
set label '$I_5$' at 0.22,0.08

p 'isoscattering_curve.dat' u 1:2 w l ls 1 t 'Background subtracted', 'isoscattering_curve_RAW.dat' u 1:2 w l ls 2 t 'Raw data'