reset

set term push
set term postscript enhanced eps color solid "Times" 18 size 5,4
set out "fig2.eps"

set multiplot

set log
unset log cb
set grid
set xlabel '{/Times-Italic q} / nm^{-1}' font "Times,28"
set ylabel 'Scattering Intensity / a.u.' font "Times,28" offset 2,-1
set autoscale
set xrange [0.023:0.5]
set yrange [0.3:4e3]
set key font "Times,24"
set key spacing 5
#set key 0.075,5
set xtics font "Helvetica,20"
set xtics (0.03,0.05,0.1,0.2,0.3,0.5)
set ytics font "Helvetica,20" 

set size 1.025,1
set origin 0,0

set palette rgb 30,31,32
set cblabel 'Solvent Electron Density / nm^{-3}' font "Times,18" offset -1,0  rotate by -90
set cbtics font "Helvetica,14" offset -1,0

N=2.e11

list = system('ls curves_*')
p for [file in list] file.'' u 1:($2/N) w l lw 7 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:13]+0.0) w l lw 5 palette notitle

################################################## 2nd plot

set size 0.485,0.475
set origin 0.39,0.5
set logscale xy
set grid
set xlabel '{/Times-Italic q} / nm^{-1}' font "Times,18" offset 0,0.6
set ylabel 'Rel. Std. Deviation' font "Times,18" offset 3.7,0.3
set autoscale
set yrange [0.05:0.8]
set xrange [0.05:0.25]
unset xtics
set xtics font "Helvetica,14"
set ytics font "Helvetica,14" 
set ytics (0.05,0.1,0.2,0.4,0.8)
set xtics (0.05,0.1,0.2)
unset key
p 'isoscattering_curve.dat' u 1:2 w l lw 6 lc rgb 'red' notitle

replot

unset multiplot

set out
set term pop
! convert -density 600 fig2.eps ../fig2.pdf
! convert -density 600 fig2.eps ../fig2.png
