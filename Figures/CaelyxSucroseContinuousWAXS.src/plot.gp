set log x
#unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / cm$^{-1}$' offset 2,-1
set autoscale
set xrange [1.8:3.]
set yrange [0:1.e-3]

set key spacing 1.5
set key 0.075,5
set xtics (2.,2.5,3.)

set cblabel '\fsmedium Solvent Osmolality / mOsm kg$^{-1}$' offset -3,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'

set cbrange [200:1500]

N=1

list = system('ls WAXS_*.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[14:-6]+0.0) w l lt 1 lw 6 palette notitle

