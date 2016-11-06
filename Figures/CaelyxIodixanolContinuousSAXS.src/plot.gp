set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / cm$^{-1}$' offset 1,-1
set autoscale
set xrange [0.03:1]
set yrange [2.e-3:1.e2]

set key spacing 1.5
set key at 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

set cblabel '\smaller Solvent Electron Density / nm$^{-3}$' offset -1.5,0  rotate by -90
set cbtics offset -1,0 format '\smaller %.0f'

set cbrange [366:342]

N=1.05e14

list = system('ls curves_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:-6]+0.0) w l lt 1 lw 6 palette notitle

