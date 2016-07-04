set xtics nomirror
set x2tics nomirror

set grid

set autoscale
set xrange [0:8.5]

set ylabel 'Normalized $\chi^2$' offset 2
set xlabel 'Sucrose Mass Fraction / $\%$'
set x2label 'Solvent Osmolality / mOsm kg$^{-1}$' rotate by 270


concmin=0.0001
concmax=8.5

osm(conc)=1000*1000/(342.3*(1/(0.01*conc)-1))+312


set xrange [concmin:concmax]
set x2range [osm(concmin):osm(concmax)]
#set y2tics (1.2,2,4, 7)
#set yrange [concmax:concmin]


p 'chisquared_SSL_400.dat' u 1:2 w lp ls 1 not# 'Deviation from liposome in buffer'#, '' u 1:3 w lp ls 2 t 'Max. sucrose'
