set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.023:0.5]
set yrange [0.3:4e3]

set key spacing 1.5
set key at 0.075,5
set xtics (0.03,0.05,0.1,0.2,0.3,0.5)

set cblabel '\smaller Solvent Electron Density / nm$^{-3}$' offset -1.5,0  rotate by -90
set cbtics offset -1,0 format '\smaller %.0f' offset 0.

N=2.e11

list = system('ls curves_*')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:13]+0.0) w l lt 1 lw 6 palette notitle

