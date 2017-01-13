set multiplot

N=1e8

set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Scattering Intensity / a.u.'offset 0.5
set format y "$10^{%L}$"
set autoscale
set xrange [0.012:0.5]
set yrange [1e2:3.e7]
set key spacing 1.5 at 0.09,5 samplen 2 width -5
set xtics (0.02,0.05,0.1,0.2,0.5)

set size 1,1
set origin 0,0

set cblabel '\smaller $\Delta \eta$ / nm$^{-3}$' offset -3,0  rotate by -90
set cbtics format '\smaller %.0f' offset 0.25,0

#set cbrange [360.3:333.7]
ymin=2e5
ymax=7e5
xmin=0.075
xmax=0.093

### This is to plot the square. You can skip this ###
set arrow from (xmax+xmin)/2,ymax to 0.15,5e6 lw 1 back filled
set arrow from xmin,ymin to xmax,ymin lw 1.5 lc rgb 'black' front nohead
set arrow from xmin,ymax to xmax,ymax lw 1.5 lc rgb 'black' front nohead
set arrow from xmin,ymax to xmin,ymin lw 1.5 lc rgb 'black' front nohead
set arrow from xmax,ymax to xmax,ymin lw 1.5 lc rgb 'black' front nohead
###################################

list=system('ls -1 coreshell_solv_*')
p  for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle, for [file in list] file.'' u 1:($2/N):(file[16:-4]+0.0) w l lt 1 lw 6 palette notitle

################################################## 2nd plot

set size 0.29,0.35
set origin 0.53,0.63

unset arrow
#unset logscale xy
set grid
unset xlabel
unset ylabel
set autoscale
set yrange [ymin:ymax]
set xrange [xmin:xmax]
unset xtics
unset ytics
#set ytics format '\smaller %g' offset 0.5
set xtics format '\smaller %g' offset 0, 0.25
set xtics (0.08, 0.09)
#set ytics (330.,340.,350.,360.)
unset key

unset colorbox

p  for [file in list] file.'' u 1:($2/N) w l lt 1 lw 5 lc rgb 'black' notitle, for [file in list] file.'' u 1:($2/N):(file[16:-4]+0.0) w l lt 1 lw 3 palette notitle

#replot

unset multiplot
