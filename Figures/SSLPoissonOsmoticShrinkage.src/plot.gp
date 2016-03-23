set grid
set xlabel '1/Radius / nm$^{-1}$' offset 1
set ylabel 'Pressure difference / mOsm kg$^{-1}$' offset -0.5
set autoscale
set xrange[0.019:0.025]
set yrange [180:260]
#set yrange [160:540]


#set style function lines

#set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
#unset colorbox

#set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
#set style line 1 lt 0 lw 5# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

#set arrow from -4.5,143.98 to 6.,143.98 lt 1

#set label "Osmotic Shrinkage" at 0.022,200 font "Helvetica, 24" tc rgb '#6D6AD1'

#set label "Bilayer Deformation" at 0.02,450 font "Helvetica, 24" tc rgb '#6D6AD1'

#set label "Caelyx" at 0.0223,360 font "Helvetica, 24" tc rgb 'black'

g(x)=a*x

fit g(x) 'SSL_isopoint.dat' u (2./$1):2 via a

p g(x) ls 2 notitle, 'SSL_isopoint.dat' u (2./$1):2 w p ls 1 notitle #ps 3 pt 13 lc rgb 'red', "< echo '0.02326 358'" w p ps 3 pt 13 lc rgb 'black', 'SSL_bilayer.txt' u (2./$1):2 w p ps 2 pt 7 lc rgb 'red'

unset key

