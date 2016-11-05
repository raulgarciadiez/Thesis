luft = 0.2014686
wasser = 0.07197752
galden = 0.0206771636363637


fit [4:10] luft 'Hilgenberg_-0.15.dat' u 2:3 via luft
fit [-5:3] wasser 'Hilgenberg_-0.15.dat' u 2:3 via wasser

print luft, wasser



set log y

set key at 0.8,0.19

set yrange [0.065:0.22]
set xrange [-5:10]

set xlabel "Vertical position / mm"
set ylabel "Transmission" offset 2

set ytics (0.07, 0.1, 0.15, 0.2)

set key samplen 2 width -5 spacing 1.5

plot "Hilgenberg_-0.15.dat" every 2 u 2:3 w lp ls 1 t '\smaller Transmission', luft ls 1 lc rgb 'grey' t '\smaller Glass only', wasser ls 2 t '\smaller H$_2$O'   #, galden ls 3 t "Galden"
