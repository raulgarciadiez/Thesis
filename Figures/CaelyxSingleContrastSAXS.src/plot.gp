set log
set grid

set xlabel '$q$ / nm$^{-1}$' offset 0,1
set ylabel 'Scattering Intensity / arb.units' offset 2,0

set autoscale
set xrange [0.035:1.]
set yrange [3:300.]

p 'caelyx_water.dat' u 1:($2/1e12) w l ls 1 notitle

