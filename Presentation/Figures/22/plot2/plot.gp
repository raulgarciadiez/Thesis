reset 
l '../../style.gp'


set grid

#set y2tics

set ylabel 'Diffraction Peak Deviation / %' offset 2.2
#set y2label 'Debye-Scherrer Width Deviation / $\%$' rotate by 270 tc rgb 'red'
set xlabel 'Solvent Osmolality / mOsm kg^{-1}'


qdif=2.28
dev=0.333

osm_thres=670.
set arrow from first osm_thres,graph 0 to first osm_thres,graph 1 nohead ls 2

#set y2tics tc rgb 'red'

set xtics (250,500,750,1000,1250,1500)

set yrange [-2.2:1.8]
#set y2range [-20:12]

unset key

p 'diffraction_peak_parameters.dat' u 1:(100*($2-qdif)/qdif) w p ls 2 t 'Peak position'#, '' u 1:(100*($3-dev)/dev) w p ls 1 t 'Peak width' axis x1y2


set out "plot.eps"
replot
set out
set term pop
! convert -density 600 plot.eps ../plot2.pdf
! convert -density 600 plot.eps ../plot2.png

