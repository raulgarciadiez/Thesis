set log

set xtics (0.05,0.1,0.2,0.3)
set grid
set xrange [0.029:0.4]
set yrange [0.33:2.1e3]
N=1e13

p 'PS-IgG-hdf_fcm_201412_217_Sam_21.3.dat' u 1:(($2*8*4-5e13)/N) w l ls 1 t '4 mg/mL IgG', 'PS-Kisker-Aug2014.dat' u 1:($2/N) w l ls 2 title 'Original', 'PS-BSA-2.dat' u 1:($2*8/N) w l ls 3 title 'BSA-2', 'PS-Serum.dat'u 1:(($2*13-19e12)/N) w l ls 1 lc rgb 'grey' title 'Serum'
