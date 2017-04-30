load '../style.gp'

set log
set grid
set xlabel '{/Times-Italic q} / nm^{-1}' 
set ylabel 'Intensity / a.u.' 

set autoscale
set xrange [0.025:1.]
set key spacing 5


set xtics (0.03,0.06,0.1,0.2,0.5,1)
#set xtics ("0.03" 0.03,"0.06" 0.06,"0.1" 0.1,"0.2" 0.2, "0.5" 0.5, "1" 1) 


p 'PS-curve-Sph.dat' every 2 u 1:($2/10000) ls 5 t 'Experimental Data', '' u 1:($3/10000) ls 2 w l t 'Sphere Fit', '' u 1:((1890.91*($1**(-2.04))+20803)/10000) w l ls 3 t 'Background'

set out "plot1.eps"
replot
set out
set term pop
! convert -density 200 plot1.eps plot1.png
! convert -density 200 plot1.eps plot1.pdf
