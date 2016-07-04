set terminal epslatex size 7cm,11cm color colortext


set log
unset log cb
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.25:2.3]
set yrange [1.3e-1:4.e0]
set cbrange [0:10.5]

set key spacing 1.5
#set key 0.075,5
set xtics (0.5,1.,2.)
set ytics (0.2,.5,1.,2)

set cblabel 'Sucrose Concentration / $\%$' offset -1,0  rotate by -90
set cbtics offset -1,0 format '\fsmedium %g'

N=0.3

list = system('ls curves*.dat')
p for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(n)*N)) w l lt 1 lw 7 lc rgb 'black' notitle,\
for [n=1:words(list)] word(list,n).'' u 1:($2*(0.5+(n)*N)):(word(list,n)[8:-4]+0.0) w l lt 1 lw 5 palette notitle,\
'REF_curves_0.0.dat' u 1:($2/4.5) w l lt 1 lw 7 lc rgb 'black' notitle, '' u 1:($2/4.5):(0.0) w l lt 1 lw 5 palette notitle,\
'REF_curves_10.5.dat' u 1:($2*1.1) w l lt 1 lw 7 lc rgb 'black' notitle, ''  u 1:($2*1.1):(10.5) w l lt 1 lw 5 palette notitle
