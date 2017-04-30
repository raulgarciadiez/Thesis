reset

load '../style.gp'

set log
set grid

set xlabel '{/Times-Italic q} / nm^{-1}'
set ylabel 'Intensity / a.u.'

set autoscale
set xrange [0.025:1.]
set yrange [3:1e5]

set xtics (0.02,0.05,0.1,0.2,0.5,1)

#set format y "10^{%T}"
p 'PMMA-curve.dat' every 7 u 1:($2/20000) ls 5 title 'Experimental Data'#, '' u 1:($3/20000) ls 2 w l  title 'Form Factor Fit', '' u 1:(8.1073/2) w l ls 3 title 'Background'

set out "image1.eps"
replot
set out
set term pop
! convert -density 200 image1.eps image1.png
! convert -density 200 image1.eps image1.pdf
