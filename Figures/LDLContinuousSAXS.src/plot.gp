set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.12:2.]
set yrange [0.5:5.e2]

set key spacing 1.5
set key at 0.075,5
set xtics (0.2,0.5,1, 2)

set cblabel '\fsmedium Solvent Electron Density / nm$^{-3}$' offset -1,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'

set cbrange [385:333.6]
set format cb "%.1f"

N=1.e11

list = system('ls curves_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:-6]+0.0) w l lt 1 lw 6 palette notitle

