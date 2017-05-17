reset 
l '../../style.gp'

set log x
#unset log cb
set grid
set xlabel '{/Times-Italic q} / nm^{-1}' offset 0,0.5
set ylabel 'Scattering Intensity / cm^{-1}' offset 3,0
set autoscale
set xrange [1.8:3.]
set yrange [0:1.e-3]

set key spacing 1.5
set key at 0.075,5
set xtics (2.,2.5,3.)

set cblabel 'Solvent Osmolality / mOsm kg^{-1}' offset -1.5,0  rotate by -90 font "Times,20"
set cbtics offset -0.3,0 format '%.0f' font "Times,16"

set cbrange [200:1500]

N=1

list = system('ls WAXS_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 4 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[14:-6]+0.0) w l lt 1 lw 2 palette notitle

set out "plot.eps"
replot
set out
set term pop
! convert -density 600 plot.eps ../plot1.pdf
! convert -density 600 plot.eps ../plot1.png


