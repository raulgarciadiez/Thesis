set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / cm$^{-1}$' offset 2,-1
set autoscale
set xrange [0.03:1.15]
set yrange [5.e-2:6.e1]

set key spacing 1.5
set key 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

set cblabel '\fsmedium Solvent Osmolality / mOsm kg$^{-1}$' offset -1,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'
#set cbtics offset -1,0 format '\fsmedium %g'

set cbrange [160:2080]
#set format cb "%.1f"

N=1.05e14*0.3

list = system('ls curves_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[8:-6]+0.0) w l lt 1 lw 6 palette notitle

