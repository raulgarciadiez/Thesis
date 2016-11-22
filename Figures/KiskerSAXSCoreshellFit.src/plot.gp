set multiplot

set log
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Scattering Intensity / a.u.'offset 2
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

p 'Coreshell_fit_334.35.dat' u 1:($2/N) w l ls 1 notitle,'curve_334.35-1.dat' u 1:($2/N) every 2 w p ls 1 t '\smaller 11.4 nm$^{-3}$', 'Coreshell_fit_345.40.dat' u 1:($2/N) w l ls 2 notitle, 'curve_345.4-1.dat' u 1:($2/N) every 2 w p ls 2 t '\smaller 0.4 nm$^{-3}$', 'Coreshell_fit_356.99.dat' u 1:($2/N) w l ls 3 notitle, 'curve_356.99-2.dat' u 1:($2/N) every 2 w p ls 3 t '\smaller -11.2 nm$^{-3}$'

#p NaN w p ls 1 t 'PS-Plain in buffer', 'core_shell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 2 t 'Core-Shell Fit','linshell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 3 t 'Onion Model', 'core_shell_AutoSAXS.dat' u 1:($2/1.e3-C0) every 2 w p ls 1 ps 2 lc rgb 'white' notitle, ''  u 1:($2/1.e3-C0) every 2 w p ls 1  ps 1.5 notitle

################################################## 2nd plot


RCS=49.7
nu=44.2/49.7
mu=0.4966950172306702
rhoc=339.7
rhow=333.2
rhos=361.9

f(x)=rhoc
g(x)=rhos
h(x)=rhow

set size 0.56,0.53
set origin 0.4,0.42
unset logscale xy
set grid
set xlabel '\smaller $R$ / nm' offset 0, 0.75
set ylabel '\smaller $\rho_e$ / nm$^{-3}$' offset 4,0.
set autoscale
set yrange [330.:365.]
set xrange [0.:52.]
unset xtics
set ytics format '\smaller %g' offset 0.5
set xtics format '\smaller %g' offset 0, 0.25
set xtics (0, 10, 20, 30, 40, 50)
set ytics (330.,340.,350.,360.)
unset key
#set arrow from ROnion,rhow to ROnion,346.31 nohead ls 3
p x < RCS*nu ? f(x) : (x >= RCS*nu && x<RCS) ? g(x) : h(x) ls 2 t 'Core-shell',h(x) lc rgb 'cyan'  t 'Solvent'

#replot

unset multiplot
