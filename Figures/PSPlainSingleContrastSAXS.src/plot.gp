set multiplot

set log
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Scattering Intensity / a.u.'offset 2
set autoscale
set xrange [0.02:0.75]
set yrange [0.1:3e4]
set key spacing 1.5
set key 0.13,2
set xtics (0.02,0.03,0.05,0.1,0.2,0.3,0.5)

C0=4.45
set size 1,1
set origin 0,0

p NaN w p ls 1 t 'PS-Plain in buffer', 'core_shell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 2 t 'Core-Shell Fit','linshell_AutoSAXS.dat' u 1:($3/1.e3-C0) w l ls 3 t 'Onion Model', 'core_shell_AutoSAXS.dat' u 1:($2/1.e3-C0) every 2 w p ls 1 ps 2 lc rgb 'white' notitle, ''  u 1:($2/1.e3-C0) every 2 w p ls 1  ps 1.5 notitle

################################################## 2nd plot

ROnion=74.43

RCS=73.967
nu=0.942
mu=0.4966950172306702
rhoc=340.
rhow=333.2
rhos=rhow+(rhoc-rhow)/mu

f(x)=rhoc
g(x)=rhos
h(x)=rhow

set size 0.45,0.43
set origin 0.53,0.51
unset logscale xy
set grid
set xlabel '\footnotesize{$R$} / nm' 
set ylabel '\footnotesize{Electron Density / nm$^{-3}$}' offset 3,0.3
set autoscale
set yrange [333.:348.]
set xrange [0.:78.]
unset xtics
set ytics format '\footnotesize %g'
set ytics (333.,336.,339.,342.,345.,348.)
unset key
set arrow from ROnion,rhow to ROnion,346.31 nohead ls 3
p x < RCS*nu ? f(x) : (x >= RCS*nu && x<RCS) ? g(x) : h(x) ls 2 t 'Core-shell',h(x) lc rgb 'cyan'  t 'Solvent', 'linshell_result.txt' u (ROnion*($0/7)**(1./3.)):1 w l ls 3 t 'Onion Model'

#replot

unset multiplot
