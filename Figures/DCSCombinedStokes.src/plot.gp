set grid
set xlabel 'PS-Plain density / g cm$^{-3}$' 
set ylabel 'PS-Plain diameter / nm' offset 0.5
set autoscale
set xrange [1.01:1.13]
set yrange [60:330]
set key spacing 1.5
set key at 1.105,310


set arrow from 1.052,200 to 1.052,155 head ls 3 #lw 3 lc rgb 'grey'

p 'DCS_results.dat' u 1:3:($1-$2):($1+$2):($3-$4):($3+$4) w xyerrorbars ls 1 t 'Standard disc', '' u 1:3 w l ls 1 notitle, '' u 6:8:($6-$7):($6+$7):($8-$9):($8+$9) w xyerrorbars ls 2 t 'Low density disc', '' u 6:8 w l ls 2 notitle
#p 'DCS_results.dat' u 1:3:($1-$2):($1+$2):($3-$4):($3+$4) w xyerrorbars ls 11 lw 3 lc rgb 'red' t 'Standard disc', '' u 1:3 w l ls 11 lw 3 lc rgb 'red' notitle, '' u 6:8:($6-$7):($6+$7):($8-$9):($8+$9) w xyerrorbars ls 7 lw 3 t 'Low density disc', '' u 6:8 w l ls 7 lw 3 notitle

#p 'DCS_results.dat' w lp ls 7 lw 2 ps 2 lc rgb 'black' t 'Standard disc', '' u 4:5 w lp ls 13 lw 2 ps 2 lc rgb 'red' t 'Low density disc'


