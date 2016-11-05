set xlabel 'Horizontal Position / mm'
set ylabel 'Vertical Position / mm'
set cblabel 'Sample Thickness / mm' rotate by 270
 
set cbrange [0.985:1.015]
set view map

set contour both
#unset surface
#set cntrparam levels auto
set cntrparam cubicspline
set cntrparam levels incremental 0.985, 0.01, 1.016
set cntrparam points 10

set cbtics (0.99,1.,1.01)
set xtics (-2,-1,0,1,2)
set ytics (-4,-2,0,2,4)


ymin=-5
ymax=4
xmin=-2.35
xmax=2.5
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set arrow from 2.05,ymin to 2.05,ymax lw 10 lt 1 lc rgb 'black' nohead front

set arrow from -2.05,ymin to -2.05,ymax lw 10 lt 1 lc rgb 'black' nohead front

sp 'Hilgenberg-1mm-sep_Glass_norm.dat' u ($1-93.65):2:(-log($3)/1.037) w pm3d lt 1 lw 5  notitle

