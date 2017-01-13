set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.03:0.5]
set yrange [0.6:1.5e3]

set key spacing 1.5
set key at 0.075,5
set xtics (0.03,0.05,0.1,0.2,0.3,0.5)

set cblabel '\smaller Solvent Electron Density / nm$^{-3}$' offset -2,0  rotate by -90
set cbtics format '\smaller %.0f' offset 0.25,0

set cbrange [360.3:333.7]

N=1.e22

list = system('ls curve_*.dat')
p 'water_capillary_rect2.dat' u 1:($2/(N/6.5e9)) w l ls 2 lw 6 lc rgb 'grey' notitle, for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[7:-6]+0.0) w l lt 1 lw 6 palette notitle

