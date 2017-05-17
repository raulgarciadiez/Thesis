reset 
l '../../style.gp'

set log
unset log cb
set grid
set xlabel '{/Times-Italic q} / nm^{-1}'  offset 0,0.2
set ylabel 'Scattering Intensity / cm^{-1}' offset 2.5,0
set autoscale
set xrange [0.03:1]
set yrange [2.e-3:1.e2]

set key spacing 1.5
set key at 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

set cblabel 'Solvent Electron Density / nm^{-3}' offset -1,0  rotate by -90 font "Times,20"
set cbtics offset -.5,0 format '%.0f' font "Times,16"

set cbrange [366:342]

N=1.05e14

list = system('ls curves_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 4 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:-6]+0.0) w l lt 1 lw 2 palette notitle


set out "plot.eps"
replot
set out
set term pop
! convert -density 600 plot.eps ../plot1.pdf
! convert -density 600 plot.eps ../plot1.png

