set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 1.2,-1
set autoscale
set xrange [0.03:1.13]
set yrange [5.e-1:6.e3]

set key spacing 1.5
set key at 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

set cblabel '\smaller Sucrose Mass Fraction / $\%$' offset -3,0  rotate by -90
set cbtics offset -1,0 format '\smaller %.0f'

set cbrange [0:27.4]

set arrow from 0.13,2.8 to 0.175,5.4 lw 2 lc rgb 'black'

set label '\smaller \shortstack{Pseudo\\Isoscattering\\Point}' at 0.07,2. tc rgb 'black' center


N=1.

list = system('ls -r DEF_curves_*_502.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[12:-6]+0.0) w l lt 1 lw 6 palette notitle


