set grid
set log y


set xlabel 'Photon Energy / keV'
set ylabel 'Photon flux / s$^{-1}$' offset 1.5,0

set xrange [ 1.7 : 10. ] #noreverse nowriteback
set yrange [ 1e10 : 3.2e11 ] #noreverse nowriteback

set format y "$10^{%L}$"

set key samplen 2 width -5


p 'power_fcm1.dat' u 1:(3*$2*1e-6/($1*1000*1.602e-19)) w l ls 1 t '\smaller InSb(111) / MgF$_2$','power_fcm2.dat' u 1:(3*$2*1e-6/($1*1000*1.602e-19)) w l ls 2 t '\smaller{Si(111) / Pt}', 'power_fcm3.dat' u 1:(3*$2*1e-6/($1*1000*1.602e-19)) w l ls 3 t '\smaller{Si(111) / MgF$_2$}'
