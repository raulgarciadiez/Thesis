Tglass=0.202

set xlabel 'Horizontal Position / mm'
set ylabel 'Vertical Position / mm'
set cblabel 'Deviation /$\%$' rotate by 270
 
set cbrange [-2:1]
set view map

set contour both
#unset surface
#set cntrparam levels auto
set cntrparam cubicspline
set cntrparam levels incremental -1, 0.5, 1.1
set cntrparam points 10



ymin=5
ymax=9.8
xmin=-2.35
xmax=2.5
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set arrow from 2.05,ymin to 2.05,ymax lw 10 lt 1 lc rgb 'black' nohead front

set arrow from -2.05,ymin to -2.05,ymax lw 10 lt 1 lc rgb 'black' nohead front

sp 'Hilgenberg-1mm-sep.dat' u ($1-93.65):2:(100*($3-Tglass)/Tglass) w pm3d lt 1 lw 5 notitle

