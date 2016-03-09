set grid
set y2tics nomirror
set ytics nomirror

set autoscale

set log y

set xlabel 'Energy / eV'
set ylabel 'X-ray Transmission / $\%$'
set y2label 'Ratio' rotate by 270 offset -1 textcolor rgb 'blue'

set y2range [1.15:3.55]
set yrange [6.3e-2:70]

set key 10000, 4

set y2tics textcolor rgb "blue"

p 'glass_hilgenberg_transmission.dat' u 1:($2*100) w l ls 3 lc rgb 'grey' t 'Capillary', 'sucrose0_filter_transmission.dat' u 1:($2*100) w l ls 1 t '0$\%$ sucrose', 'sucrose65_filter_transmission.dat' u 1:($2*100) w l ls 2 t '65$\%$ sucrose', '<paste sucrose0_filter_transmission.dat sucrose65_filter_transmission.dat' u 1:($2/$4) w l axes x1y2 ls 3 t 'T$_{0\%}$/T$_{65\%}$'
