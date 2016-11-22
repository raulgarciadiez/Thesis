#set terminal epslatex size 15cm,12cm
#

set logscale xy
set grid
set xlabel '$q$ / nm$^{-1}$' offset 0,0.1
set ylabel 'Rel. Std. Deviation' offset 1.7
set autoscale
set yrange [0.02:1.15]
set xrange [0.05:0.25]
set ytics (0.02,0.05,0.1,0.2,0.5,1.)
set xtics (0.05,0.1,0.2)
set key spacing 1.5 samplen 2 width -5

set label '$I_1$' at 0.057,0.08
set label '$I_2$' at 0.0975,0.065
set label '$I_3$' at 0.135,0.06
set label '$I_4$' at 0.1752,0.085
set label '$I_5$' at 0.2165,0.08

p 'isoscattering_curve.dat' u 1:2 w l ls 1 t '\smaller Background subtracted', 'isoscattering_curve_RAW.dat' u 1:2 w l ls 2 t '\smaller Raw data'
