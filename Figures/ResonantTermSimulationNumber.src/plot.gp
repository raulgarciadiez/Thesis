set grid
set xlabel 'Number of scattering curves'
set ylabel 'Diameter / nm' offset 1.5
set autoscale
#set xrange [0.025:0.4]
set yrange [139.5:150.5]

set style arrow 1 nohead ls 2

D=146.8
set arrow from 0,D to 35,D as 1

p 'resonant_term_individual.dat' u 1:2:3 w yerrorbars ls 1 notitle



