set grid
#set log
set xlabel 'Sucrose Mass Fraction / $\%$' offset 1
set ylabel 'Normalized $\chi^2$' offset -0.5
set autoscale
#set key spacing 5
#set bmargin 8

#set style function lines

#set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
#unset colorbox

#set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
#set style line 1 lt 0 lw 5# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

set arrow from 15,10 to 15,5 lw 5 lc rgb 'blue'

set label "Bilayer\nDeformation" at 15,13.2 tc rgb 'blue' center


p 'chisq_SSL.dat' w p ls 1 t 'Diff. to SSL in buffer', '' u 1:3 w p ls 2 t 'Diff. to SSL in max. osmolality',
