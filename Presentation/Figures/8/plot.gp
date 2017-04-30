l '../style.gp'

f(x)=1.2863*x+333.189
set autoscale
set xrange [0:50]
set grid

set xlabel 'Sucrose Mass Fraction / %' offset 0,0.25
set ylabel 'Electron density / nm^{-3}' offset 2

set key spacing 5

p 333.2 w l lw 3 lt rgbcolor "#1E90FF", 339.7 w l lw 3 lt rgbcolor "#787878", 383.4 w l lw 3 lt rgbcolor "#A3A3A3", f(x) w l lw 7 lt rgbcolor '#FF4040'
set label "PMMA" at 2,386.5 font ",30" textcolor rgbcolor "#A3A3A3"
set label "PS" at 44,342.5 font ",30" textcolor rgbcolor "#787878"
set label "Water" at 42,336 font ",30" textcolor rgbcolor "#1E90FF"

unset key

set out "plot.eps"
replot
set out
set term pop
! convert -density 300 plot.eps plot.png
! convert -density 300 plot.eps plot.pdf
