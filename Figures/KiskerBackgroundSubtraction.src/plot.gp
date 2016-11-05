set log

N=1e22
Nsubs=6.5e9

set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale

set xrange [0.032:1]
set yrange [0.3:3e1]

set xtics (0.05,0.1,0.2,0.5,1.)

set key spacing 1.5 samplen 2 width -5

p 'curve_345.4-1.dat' u 1:($2/N) w l ls 3 t '\smaller Original curve', 'water_capillary_rect2.dat' u 1:($2/(N/Nsubs)) w l ls 2 t '\smaller Water Background',  'curve_BG_subtracted.dat' u 1:($2/N):($3/N) w e ls 1 t '\smaller Subtracted Curve'
