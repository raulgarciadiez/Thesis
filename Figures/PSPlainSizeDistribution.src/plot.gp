set grid
set xlabel 'Diameter / nm' 
set ylabel 'Frequency / a.u.' offset 1
set autoscale
set xrange[50:190]
set yrange [-0.025:1.2]
set key spacing 1.5
set key at 138,1.18


hist(x,width)=width*floor(x/width)+width/2.0

gauss(x,mu,sigma)=exp(-(x-2*mu)**2/(2*(2*sigma)**2))

#set style line 1 lt 3 lw 10 lc rgb "blue"

#set style line 2 lt 4 lw 10 lc rgb "black"

set boxwidth 0.6 relative 
set style fill solid 1.0

p 'PS4_TSEM.dat' every ::1 u 1:($2/150.) w boxes fill lc rgb 'grey' t '\footnotesize TSEM', gauss(x,73.4,1.9284) ls 1 t '\footnotesize Shape Function SAXS', 'PS4_DLS_Normal_disc.dat' u 1:7 w l ls 2 t '\footnotesize Standard DCS','PS4_DLS_Low_disc.dat' u 1:7 w l ls 3 t '\footnotesize Low density DCS'

