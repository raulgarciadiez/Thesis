set grid
set xlabel '$\rho_{\text{max}}$ / nm$^{-3}$'
set ylabel 'Isoscattering point deviation / $\%$'  offset 1.5,0
set autoscale
#set xrange [0.025:0.4]
ymin=-0.7
ymax=1.6
set yrange [ymin:ymax]

rhoOnion=340.55
set arrow from rhoOnion,ymin to rhoOnion,ymax nohead ls 4

p 'isopoint_deviation_onion_model.dat' every 3 u 1:2 w p ls 1 notitle


