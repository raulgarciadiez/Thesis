
set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / cm$^{-1}$' offset 2,-1
set autoscale
set xrange [0.25:2.2]
set yrange [1.9e-1:2.4e3]

#set key spacing 1.5
#set key 0.075,5
set xtics (0.5,1.,2.)
set ytics (0.2,.5,1.,2)
set cbrange [0:25]

set cblabel 'Sucrose Concentration / $\%$' offset -1,0  rotate by -90

N=0.3

#list = system('ls curves*.dat')

list=system("ls -1t curves*410*")# curves*623*")

print list




p for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(word(list,n)[8:-4])*n)) w l lt 1 lw 7 lc rgb 'black' notitle,\
for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(word(list,n)[8:-4])*n)):(word(list,n)[8:-4]+0.0) w l lt 1 lw 5 palette notitle,\
#'HSPC_100_water.dat' u 1:($2/.3-2.):(0.0) w l lt 1 lw 5 palette notitle, ''  u 1:($2/.3-2) w l lt 1 lw 7 lc rgb 'black' notitle,\
#'HSPC_100_Sucr.dat' u 1:(2.2*($2*300-700)) w l lt 1 lw 7 lc rgb 'black' notitle, ''  u 1:(2.2*($2*300-700)):(34.11) w l lt 1 lw 5 palette notitle
