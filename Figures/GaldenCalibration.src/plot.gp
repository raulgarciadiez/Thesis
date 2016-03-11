luft = 0.2014686
wasser = 0.07197752
galden = 0.0206771636363637

set log y

set key at 9,0.05

set yrange [0.019:0.22]

set xlabel "Vertical position / mm"
set ylabel "Transmission"

set ytics (0.02,0.05, 0.1, 0.2)

plot "Hilgenberg_-0.15.dat" every 2 u 2:3 w lp ls 1 t "Transmission", luft ls 1 lc rgb 'grey' t "Glass only", wasser ls 2 t "H$_2$O", galden ls 3 t "Galden"

