set grid

#set autoscale

set xlabel 'Sucrose Mass Fraction / $\%$'
set ylabel 'Electron Density / nm$^{-3}$' offset 2
set y2label 'Osmolality / mOsm kg$^{-1}$' rotate by 270

concmin=0.0001
concmax=35.

osm(conc)=1000*1000/(342.3*(1/(0.01*conc)-1))#+312

den(conc)=126.81*conc/100.+333.19

set ytics nomirror
set y2tics nomirror

set xrange[concmin:concmax]
set yrange [den(concmin):den(concmax)]
set y2range [osm(concmin):osm(concmax)]

p den(x) ls 1 not