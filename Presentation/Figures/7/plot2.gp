
load '../style.gp'

set log
set grid

set xlabel '{/Times-Italic q} / nm^{-1}'
set ylabel 'Intensity / a.u.'

set autoscale
set grid# mxtics, mytics

#set mxtics 20
#set mytics 10
#set xtics (0.2,0.25,0.3,0.4,0.5) "
set xtics (0.03,0.06,0.1,0.2,0.5,1) 
#set xtics ("0.2" 0.2,"0.3" 0.3, "0.4" 0.4, "0.5" 0.5)
#set ytics ("3" 3,"5" 5,"7" 7,"10" 10)  

#set xrange [0.2:0.5]
set xrange [0.025:1.]
#set yrange [2.5:10]
p 'PS-curve.dat' every 2 u 1:($2/10000) w p ls 5 t 'Experimental Data', '' u 1:($3/10000) w l ls 2 t 'Core-Shell Fit', '' u 1:((-$1*7326+226.2*($1**(-2.68))+29986)/10000) w l ls 3 t 'Background'

set out "plot2.eps"
replot
set out
set term pop
! convert -density 200 plot2.eps plot2.png
! convert -density 200 plot2.eps plot2.pdf
