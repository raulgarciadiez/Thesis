#set terminal epslatex size 15cm,8cm color colortext


l '../style.gp'

set size 1.3,1


set ytics nomirror
set y2tics nomirror

set grid

set autoscale
set xrange [-0.5:11]

set xlabel 'Vertical Position / mm' offset 0,0.5
set ylabel 'Solvent electron density / nm^{-3}' offset 2
set y2label 'X-ray Transmission / %' rotate by 270 offset -3.8

set cblabel 'Diffusion Time / min' rotate by 270 offset 0
set cbtics format '%.0f'


#unset colorbox
#load '../style.gp'
#set palette


Imin=8.227
Imax=8.088

Tmin=0.000267
Tmax=0.000309

#concmin=23.72*(Imax+log(Tmin))/(Imax-Imin)

#concmax=23.72*(Imax+log(Tmax))/(Imax-Imin)

conc(T)=23.72*(Imax+log(T))/(Imax-Imin)

concmin=conc(Tmin)
concmax=conc(Tmax)

ed(C)=1.2681*C+333.19

set log y2
set y2range [100*Tmax:100*Tmin]
set y2tics (0.027,0.028,0.0295, 0.0305)

set yrange [ed(concmax):ed(concmin)]


list = system('ls trans_Kisker*')
p for [file in list] file.'' u ($1+6.0):(ed(conc($2))):(file[16:18]+0.0) w lp ls 3 palette notitle
#p for [file in list] file.'' u ($1+6.0):(23.72*(Imax+log($2))/(Imax-Imin)):(file[16:18]+0.0) w lp ls 5 lt 1 pt 7 lw 3 ps 1.5 palette notitle


set out "plot.eps"
replot
set out
set term pop
! convert -density 300 plot.eps plot.png
! convert -density 300 plot.eps plot.pdf

