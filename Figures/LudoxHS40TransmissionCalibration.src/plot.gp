set terminal epslatex size 15cm,8cm color colortext

set ytics nomirror
set y2tics nomirror

set grid

set autoscale
set xrange [0:14.5]

set xlabel 'Vertical Position / mm'
set ylabel 'Particle Mass Concentration / $\%$' offset 1
set y2label 'X-ray Transmission / $\%$' rotate by 270 offset -2.5

set cblabel '\smaller Diffusion Time / min' rotate by 270 offset -2
set cbtics format '\smaller %.0f'

#unset colorbox
#load '../style.gp'
#set palette

Imin=4.433
Imax=2.675

Tmin=0.0115
Tmax=0.073

CMAX=40.

concmin=CMAX*(Imax+log(Tmin))/(Imax-Imin)

concmax=CMAX*(Imax+log(Tmax))/(Imax-Imin)

set log y2
set y2range [100*Tmax:100*Tmin]
set y2tics (1.2,2,4, 7)
set yrange [concmax:concmin]


list = system('ls LudoxHS40_201508_032_t_*')
p for [file in list] file.'' u ($1+5.0):(CMAX*(Imax+log($2))/(Imax-Imin)):(file[24:26]+0.0) w lp ls 5 lt 1 pt 7 lw 3 ps 1.5 palette notitle
