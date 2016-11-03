set terminal epslatex size 7cm,11cm color colortext


set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.25:2.2]
set yrange [5e-1:8e2]

#set key spacing 1.5
#set key 0.075,5
set xtics (0.5,1.,2.)



#set ytics (0.5, 1., 2, 5., 10)



set cbrange [0:25]

set cblabel 'Sucrose Concentration / $\%$' offset -1,0  rotate by -90

N=0.3

#list = system('ls curves*.dat')

list=system("ls -1t curves*410*")# curves*623*")

print list

#p for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(word(list,n)[8:-4])*n)) w l lt 1 lw 7 lc rgb 'black' notitle,\
#for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(word(list,n)[8:-4])*n)):(word(list,n)[8:-4]+0.0) w l lt 1 lw 5 palette notitle,\

p 'curves_0.4162_410.dat' u 1:($2*1) w l lt 1 lw 7 lc rgb 'black' not, \
 word(list,2) u 1:($2*2) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,3) u 1:($2*4) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,4) u 1:($2*6) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,5) u 1:($2*13) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,6) u 1:($2*25) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,7) u 1:($2*40) w l lt 1 lw 7 lc rgb 'black' not, \
word(list,8) u 1:($2*80) w l lt 1 lw 7 lc rgb 'black' not, \
'curves_0.4162_410.dat' u 1:($2*1):(word(list,1)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,2) u 1:($2*2):(word(list,2)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,3) u 1:($2*4):(word(list,3)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,4) u 1:($2*6):(word(list,4)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,5) u 1:($2*13):(word(list,5)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,6) u 1:($2*25):(word(list,6)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,7) u 1:($2*40):(word(list,7)[8:-4]+0.0) w l lt 1 lw 5 palette not, \
word(list,8) u 1:($2*80):(word(list,8)[8:-4]+0.0) w l lt 1 lw 5 palette not

#'HSPC_100_water.dat' u 1:($2/.3-2.):(0.0) w l lt 1 lw 5 palette notitle, ''  u 1:($2/.3-2) w l lt 1 lw 7 lc rgb 'black' notitle,\
#'HSPC_100_Sucr.dat' u 1:(2.2*($2*300-700)) w l lt 1 lw 7 lc rgb 'black' notitle, ''  u 1:(2.2*($2*300-700)):(34.11) w l lt 1 lw 5 palette notitle

