set log

set xlabel '$q$ / nm$^{-1}$' 
set ylabel '$\sfrac{d \Sigma}{d \Omega}$ / cm$^{-1}$' offset 1

set format y "$10^{%L}$"

set grid

unset key 

#set yrange [-0.06:1.5]
set xrange [0.01:1]

set yrange [5e-4:1.3e4]

Guinier_q=0.04
Porod_q=0.3

set style rect fc lt -1 fs solid 0.05 noborder
set obj rect from graph 0, graph 0 to first Guinier_q, graph 1 back

set style rect fc lt 1 fs solid 0.05 noborder
set obj rect from first Porod_q, graph 0 to graph 1, graph 1 back

set grid front

set label "Guinier\nregion" at 0.014,5.5e3 front

set label "Porod\nregion" at 0.4,5.5e3 front

set label "Fourier region" at 0.05,4e3 front

p 'AutoSAXS_Au_100_Original.dat' u 1:(($3-3.97)/100) w l ls 1 not
# 'curve_50nm_0.88.dat' u 1:3 w l ls 1 not
