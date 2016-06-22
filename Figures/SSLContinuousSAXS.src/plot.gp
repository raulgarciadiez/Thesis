#set multiplot

set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.03:1.13]
set yrange [5.e-1:6.e3]

set key spacing 1.5
set key 0.075,5
set xtics (0.05,0.1,0.2,0.5,1.)

set cblabel '\fsmedium Sucrose Mass Fraction / $\%$' offset -3,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'

#set cbrange [160:2080]


#set format cb "%.1f"

N=1.

list = system('ls DEF_curves_*502.dat')
p for [file in list] file.'' u 1:($2/N) w l lt 1 lw 8 lc rgb 'black' notitle,for [file in list] file.'' u 1:($2/N):(file[12:-6]+0.0) w l lt 1 lw 6 palette notitle

################################################## 2nd plot

#set size 0.45,0.43
#set origin 0.53,0.51
#unset logscale xy
#set grid
#set ylabel '\footnotesize{Intensity at 0.18 nm$^{-1}$/ a.u.} '  offset 3,0.3
#set xlabel '\footnotesize{Sucrose Mass Fraction/ $\%$}'
#set autoscale
#set yrange [0:90.]
#set xrange [0.:30.]
#unset xtics
#set ytics format '\footnotesize %g'
#set ytics (333.,336.,339.,342.,345.,348.)
#unset key

#p 'isopoint_intensity.dat' w p lt 1

#unset multiplot