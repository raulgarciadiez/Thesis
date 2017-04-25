set xlabel 'Energy / eV' offset 0,0.3
set ylabel 'Radiant Power / W' offset 1

set log

set autoscale
set grid
set xrange [1:2e4]
set yrange [3e-6:4e-4]
#set xtics 0.05

set format y "$10^{%L}$"

set key spacing 1.5 samplen 2 width -5

set arrow from 2500,graph 0 to 2500,graph 1 nohead lw 3 lc rgb 'black'
set label '$E_C$' at 2700,3e-5

p 'SpectralPowerBESSY.dat' w l ls 1 not# '\smaller BESSY II'

