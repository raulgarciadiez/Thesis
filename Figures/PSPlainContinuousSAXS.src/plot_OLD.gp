set multiplot

set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.023:0.5]
set yrange [0.3:4e3]

set key spacing 1.5
set key 0.075,5
set xtics (0.03,0.05,0.1,0.2,0.3,0.5)

set size 1.025,1
set origin 0,0

set cblabel '\fsmedium Solvent Electron Density / nm$^{-3}$' offset -1,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'

N=2.e11

list = system('ls curves_*')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:13]+0.0) w l lt 1 lw 6 palette notitle

################################################## 2nd plot

set size 0.485,0.475
set origin 0.39,0.5
set logscale xy
set grid
set xlabel '\fssmall $q$ / nm$^{-1}$' offset 0,0.6
set ylabel '\fssmall Rel. Std. Deviation' offset 3.7,0.3
set autoscale
set yrange [0.05:0.8]
set xrange [0.05:0.25]
set xtics format '\fssmall %g'
set ytics format '\fssmall %g'
set ytics (0.05,0.1,0.2,0.4,0.8)
set xtics (0.05,0.1,0.2)
unset key
p 'isoscattering_curve.dat' u 1:2 w l ls 1 notitle

replot

unset multiplot
