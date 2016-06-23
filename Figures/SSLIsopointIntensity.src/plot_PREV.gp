set grid
#set log
set xlabel 'Sucrose Mass Fraction / $\%$' offset 1
set ylabel 'Isoscattering Point Intensity / a.u.' offset -0.5
set autoscale
unset key
#set bmargin 8

#set style function lines

#set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
#unset colorbox

#set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
#set style line 1 lt 0 lw 5# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

set arrow from 7.5,25 to 7.5,8 lw 5 lc rgb 'black'

set label "Osmotic Threshold" at 2.5,30 tc rgb 'black'


p 'isopoint_intensity.dat' w p ls 1
