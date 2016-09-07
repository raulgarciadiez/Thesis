set grid
set log


set xlabel 'Photon Energy / keV'
set ylabel 'Water attenuation / cm$^{-1}$' offset 1.5,0

#set xrange [ 1.7 : 10. ] #noreverse nowriteback
#set yrange [ 1e10 : 3.2e11 ] #noreverse nowriteback


p 'Water_cross_section.dat' u ($1*1e3):($4*0.998) w l ls 1 t 'Photoelectron Absorption', '' u ($1*1e3):($2*0.998) w l ls 2 t 'Coherent Scattering', '' u ($1*1e3):($3*0.998) w l ls 3 t 'Incoherent Scattering', '' u ($1*1e3):($7*0.998) w l ls 4 not# t 'Total Attenuation'

#p 'Water_cross_section.dat' u ($1*1e3):($7*0.998) w l ls 1 t 'Total Attenuation', '' u ($1*1e3):($2*0.998) w l ls 2 t 'Coherent Scattering', '' u ($1*1e3):($3*0.998) w l ls 3 t 'Incoherent Scattering', '' u ($1*1e3):($4*0.998) w l ls 4 t 'Photoelectron Absorption'
