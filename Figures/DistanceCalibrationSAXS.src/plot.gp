set multiplot

set grid
set autoscale
set xlabel 'Measured distance / mm'
set ylabel 'Radius size / pixel'
set xrange [850:2250]
set yrange [180:600]
#set key spacing 1.5
set key 1500,245
#set xtics (0.02,0.03,0.05,0.1,0.2,0.3,0.5)

set size 1,1
set origin 0,0



f(x)=a*x+b
g(x)=c*x+d

fit g(x) 'distancefit_91_inner.dat' u 6:2 via c,d
fit [1000:3000] f(x) 'distancefit_78.dat' u 6:2 via a,b
  
p 'distancefit_78.dat' u 6:2 w p ls 2 t 'AgBehe', 'distancefit_91_inner.dat' u 6:2 w p ls 1 t 'SBA', g(x) not ls 1, f(x) ls 2 not


###################################


set size 0.485,0.43
set origin 0.49,0.53

unset grid
unset xlabel 
unset ylabel 
set autoscale
set yrange [490.:515.]
set xrange [870.:1005.]
#unset xtics
set ytics format '\fssmall %g' offset 0,1
set xtics format '\fssmall %g'
set xtics (900, 950, 1000)
set ytics (490,500,510)
unset key

#set arrow from ROnion,rhow to ROnion,346.31 nohead ls 3

p 'distancefit_78.dat' u 6:2 w p ls 2 not, f(x) ls 2 not

 
unset multiplot