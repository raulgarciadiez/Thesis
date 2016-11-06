set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 1,-1
set autoscale
set xrange [0.12:2.5]
set yrange [0.1:5.e1]

set xtics (0.2,0.5,1, 2)

set cblabel '\smaller Solvent Electron Density / nm$^{-3}$' offset -1.5,0  rotate by -90
set cbtics offset 0,0 format '\smaller %0.f'

set cbrange [385:333.6]

N=1.e11

list = system('ls curves_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:-6]+0.0) w l lt 1 lw 6 palette notitle

