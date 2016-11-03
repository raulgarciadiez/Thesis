set grid

set autoscale

set xlabel 'Sucrose Mass Fraction / $\%$'
set ylabel 'Electron Density / nm$^{-3}$' offset 1
set y2label 'Osmolality / mOsm kg$^{-1}$' rotate by 270 offset -1

concmin=0.0001
#concmin=-0.14983
concmax=40.#0678

M0=342.3
C0=126.81
r0=333.19

osm(conc)=1000*1000/(M0*(1/(0.01*conc)-1))#+312

den(conc)=C0*conc/100.+r0

set ytics nomirror
#set y2tics nomirror

#set ytics nomirror
#set y2tics
#set link y2 via r0+C0*M0*(y/(1e6+y*M0)) inverse 1e6/(M0*(C0/(y-r0)-1))


set xrange[concmin:concmax]
set yrange [den(concmin):den(concmax)]
#set y2range[concmin:concmax]
#set y2range [den(concmin):den(concmax)]
set y2range [osm(concmin):osm(concmax)]

set y2range [den(concmin):den(concmax)]

set ytics nomirror
# delete all automatic tics but the one at 0
set y2tics (0) 
# add all other tics

#osm_tics='5 15 25 35'

#set for [i=5:1800:250] y2tics add (sprintf('%d',i) 1000*1000/(M0*(1/(0.01*i)-1)))
set for [i=0:1950:250] y2tics add (sprintf('%d',i) r0+C0*M0*(i/(1e6+i*M0)))

#set for [i=333:385:3] y2tics add (sprintf('%d',i) i+10)

#set for [i=0:2000:250] y2tics add (sprintf('%d',i) 1e6/(M0*(C0/(i-r0)-1)))



p den(x) ls 1 not#, osm(x) ls 1 not axis x1y2