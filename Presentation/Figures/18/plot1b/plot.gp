reset 
l '../../style.gp'

set size 0.45,0.75

set log
#unset log cb
set grid
set xlabel '{/Times-Italic q} / nm^{-1}'  offset 0,0.2
set ylabel 'Rel. Std. Deviation' offset 2.5,-1
set autoscale
set xrange [0.075:.2]
set yrange [3.e-2:1.4e0]

set key spacing 1.5 samplen 2 width -5
#set key 0.075,5
set xtics (0.08,0.1,0.15,0.2,0.5,1.)

p 'isoscattering_curve.dat' w l ls 1 not


set out "plot.eps"
replot
set out
set term pop
! convert -density 600 plot.eps ../plot1b.pdf
! convert -density 600 plot.eps ../plot1b.png


