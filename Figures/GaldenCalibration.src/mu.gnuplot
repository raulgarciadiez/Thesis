luft = 0.2014686
wasser = 0.07197752
galden = 0.0206771636363637

set log y

set key at 9,0.03

set yrange [0.02:0.21]

set xlabel "Vertical position (mm)"
set ylabel "Transmission / $\%$"
plot "Hilgenberg_-0.15.dat" u 2:3 w lp ls 1 t "Transmission", luft ls 1 lc rgb 'black' t "Glass only", wasser ls 2 t "H_2O", galden ls 3 t "Galden"

