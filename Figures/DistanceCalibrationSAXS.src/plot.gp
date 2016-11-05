set multiplot

D=4633.7

dmin=2400
dmax=4600

set tmargin 0
set bmargin 0
set lmargin 3
set rmargin 3

set grid
set autoscale
unset xlabel
set ylabel 'Radius size / pixel' offset 1,0.6
set xrange [dmin:dmax]
set yrange [220:720]
#set key spacing 1.5
set key at 3200,700 spacing 1.5
#set xtics (0.02,0.03,0.05,0.1,0.2,0.3,0.5)
set xtics format ""
set ytics (300, 400, 500, 600, 700)

set size 1,0.49
set origin 0,0.5



f(x)=a*x+b
g(x)=c*x+d

#fit g(x) 'distancefit_91_inner.dat' u 6:2 via c,d
#fit f(x) 'distancefit_78.dat' u 6:2 via a,b
###fit [1000:3000] f(x) 'distancefit_78.dat' u 6:2 via a,b

fit g(x) 'distancefit_102_SBA_Jan2015.dat' u (D-$6):2 via c,d
fit f(x) 'distancefit_126_AgBehe_Jan2015.dat' u (D-$6):2 via a,b

  
p 'distancefit_126_AgBehe_Jan2015.dat' u (D-$6):2 w p ls 2 t 'AgBehe', 'distancefit_102_SBA_Jan2015.dat' u (D-$6):2 w p ls 1 t 'SBA', g(x) not ls 1, f(x) ls 2 not
#p 'distancefit_78.dat' u 6:2 w p ls 2 t 'AgBehe', 'distancefit_91_inner.dat' u 6:2 w p ls 1 t 'SBA', g(x) not ls 1, f(x) ls 2 not


###################################

set size 1,0.4
set origin 0.,0.1

set bmargin 0.5


set ylabel 'Residuals / pixel' offset 0.25,-0.5
set xlabel 'Measured distance / mm' offset 0,0.15
set autoscale
#set yrange [490.:515.]
#set xrange [870.:1005.]
set xrange [dmin:dmax]
set yrange [-3.5:1.9]
set xtics format "%g"
set ytics (-3,-2,-1,0,1.)
unset key

#p 'distancefit_78.dat' u 6:2 w p ls 2 not, f(x) ls 2 not

p 'distancefit_126_AgBehe_Jan2015.dat' u (D-$6):(f((D-$6))-$2) w p ls 2 not, 'distancefit_102_SBA_Jan2015.dat' u (D-$6):(g((D-$6))-$2) w p ls 1 not
 
unset multiplot
