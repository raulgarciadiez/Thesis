set grid
set ylabel 'Diameter / nm' offset 1.5
set autoscale
set xrange[-4.5:4.8]
set yrange [126.:158]
set xtic rotate by -45
#set bmargin 8

#set style function lines

set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
unset colorbox

set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
#set style line 1 lt 0 lw 5			# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

#set arrow from -4.5,143.98 to 6.,143.98 lt 1

D_mean=144.98#145.07
sigma=1.64#1.77
f(x)=D_mean
g(x)=D_mean-sigma
h(x)=D_mean+sigma
i(x)=147

p  f(x) lt 1 lw 10 lc rgb 'grey' notitle, g(x) lt 0 lw 10 lc rgb 'grey' notitle, h(x) lt 0 lw 10 lc rgb 'grey' notitle, 'size_imaging.dat' u 1:3:4:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ) w yerr lw 7 lt 1 palette notitle, '' u 1:3:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ):xtic(2)w points pt 5 ps 2.5 palette notitle, 'size_DCS.dat' u 1:3:4:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ) w yerr lt 1 lw 7 palette notitle, '' u 1:3:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ):xtic(2)w points pt 13 ps 2.5 palette notitle, 'size_SAXS.dat' u 1:3:4:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ) w yerr lt 1 lw 7 palette notitle, '' u 1:3:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ):xtic(2)w points pt 7 ps 2.5 palette notitle

#p  f(x) lt 1 lw 10 lc rgb 'grey' notitle, g(x) lt 0 lw 10 lc rgb 'grey' notitle, h(x) lt 0 lw 10 lc rgb 'grey' notitle, 'size_comp.dat' u 1:3:4:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ) w yerr lw 7 palette notitle, '' u 1:3:($1>0.5 ? 0 : ($1==0.0 ? 2 : 1) ):xtic(2)w points pt 7 ps 2.5 palette notitle    #i(x) lt 0 lw 10 lc rgb 'blue' notitle

