set log
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Shape Scattering Function / a.u.' offset 2
set autoscale
set xrange [0.025:0.4]
set yrange [1:2e5]
set key spacing 1.5 width -5 samplen 2
#set key 0.09,20
set xtics (0.03,0.05,0.1,0.2,0.3)
#set format y "10^{%T}"

#set size 1,1
#set origin 0,0

p NaN w p ls 1 ps 1.5 t '\smaller Experimental Data', 'AutoSAXS_fitresults.dat' u 1:($2/1.e13):($4/1.e13) w yerrorbars ls 1 ps 1.5 notitle, '' u 1:($3/1.e13) ls 2 w l t '\smaller Spherical Model','' u 1:($2/1.e13) ls 1 ps 1.5 notitle


#p 'resonant_term.dat' u 1:($2/1.e13):($3/1.e13) w yerrorbars lc rgb 'black' t 'Experimental Data','McSAS_fitresults.dat' u ($1*1e-9):($2/1.e13) lc rgb 'blue' lw 8 w l t 'McsAS', 'AutoSAXS_fitresults.dat' u 1:($3/1.e13) lc rgb 'red' lw 8 w l t 'AutoSAXS','' u 1:($3/1.e13) pt 6 lt 0 ps 2 lw 3 notitle

##########################################################################

#set size 0.4,0.4
#set origin 0.55,0.55
#unset logscale xy
#set xlabel 'Size / nm' font "Times,18" offset 0,0.6
#set ylabel 'Frequency / a.u.' font "Times,18" offset 2.5,0
#set autoscale
#set yrange [0.:1.1]
#set xrange[2*67:2*79]
#set key font "Times,24"
#set key spacing 5
#unset xtics
#set xtics font "Helvetica,14"
#set ytics font "Helvetica,14" 
#set ytics (0.,0.2,0.4,0.6,0.8,1.)
#unset key


#gauss(x,mu,sigma)=exp(-(x-mu)**2/(2*sigma**2))

#p gauss(x,2*73.4,2*1.9284) lw 5 lc rgb 'red' notitle
#replot

#unset multiplot

