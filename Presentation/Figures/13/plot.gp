reset

l '../style.gp'

set term push
set term postscript enhanced eps color solid "Times" 18 size 5,4
set out "plot.eps"

set multiplot

unset grid

set log
#set grid
set xlabel '{/Times-Italic q} / nm^{-1}' font "Times,28"
set ylabel 'Scattering Intensity / a.u.' font "Times,28" offset 2,-1
set autoscale
set xrange [0.032:0.5]
set yrange [0.5:1.5e3]
set key spacing 1.5 at 0.09,5 samplen 2 width -5
set xtics (0.02,0.03,0.05,0.1,0.2,0.3,0.5)

C0=4.45
set size 1,1
set origin 0,0

suffixes="334.35, 345.4,356.99"

N=1.e22

p 'Coreshell_fit_334.35.dat' u 1:($2/N) w l ls 1 notitle,'curve_334.35-1.dat' u 1:($2/N) every 2 w p ls 1 t '11.4 nm^{-3}', 'Coreshell_fit_345.40.dat' u 1:($2/N) w l ls 2 notitle, 'curve_345.4-1.dat' u 1:($2/N) every 2 w p ls 2 t '0.4 nm^{-3}', 'Coreshell_fit_356.99.dat' u 1:($2/N) w l ls 3 notitle, 'curve_356.99-2.dat' u 1:($2/N) every 2 w p ls 3 t '-11.2 nm^{-3}'

#p NaN w p ls 1 t 'PS-Plain in buffer', 'core_shell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 2 t 'Core-Shell Fit','linshell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 3 t 'Onion Model', 'core_shell_AutoSAXS.dat' u 1:($2/1.e3-C0) every 2 w p ls 1 ps 2 lc rgb 'white' notitle, ''  u 1:($2/1.e3-C0) every 2 w p ls 1  ps 1.5 notitle

################################################## 2nd plot


RCS=49.7
nu=44.2/49.7
mu=0.4966950172306702
rhoc=339.7
rhow=333.2
rhos=361.9
rho0=rhoc*nu**3+rhos*(1-nu**3)

f(x)=rhoc
g(x)=rhos
h(x)=rhow
i(x)=rho0

set size 0.54,0.51
set origin 0.44,0.46
unset logscale xy
set grid
set xlabel '{/Times-Italic R} / nm' offset 0, 0.45 font "Times, 24"
set ylabel '{/Symbol r}_e / nm^{-3}' offset 1,0.  font "Times, 24"

set autoscale
set yrange [330.:365.]
set xrange [0.:52.]
unset xtics
unset ytics
set ytics format '%g' offset 0.5
set xtics format '%g' offset 0, 0.25
set xtics (0, 10, 20, 30, 40, 50)
set ytics (330.,340.,350.,360.)
unset key
#set arrow from ROnion,rhow to ROnion,346.31 nohead ls 3

set label 1 '{/Symbol r}_0' at 5,rho0+3 font "Times,22" textcolor rgbcolor "#787878"
set label "Water" at 5,rhow+2.5 font ",22" textcolor rgbcolor "#1E90FF"


#set label "PMMA" at 2,386.5 font ",30" textcolor rgbcolor "#A3A3A3"
#set label "PS" at 44,342.5 font ",30" textcolor rgbcolor "#787878"
#set label "Water" at 42,336 font ",30" textcolor rgbcolor "#1E90FF"


p  h(x)  lw 2 lc rgb '#1E90FF'  t 'Solvent', i(x) lw 2 lc rgb '#787878', x < RCS*nu ? f(x) : (x >= RCS*nu && x<RCS) ? g(x) : h(x) ls 2 lw 5 t 'Core-shell'

replot

unset multiplot


set out
set term pop
! convert -density 600 plot.eps plot.pdf
! convert -density 600 plot.eps plot.png
