set ytics nomirror
set y2tics nomirror

set grid

set autoscale
set xrange [0:14.5]

set xlabel 'Vertical Position / mm'
set ylabel 'Particle Concentration / $\%$' offset 2
set y2label 'X-ray Transmission / $\%$' rotate by 270 offset -2.5

set cblabel 'Diffusion Time / min' rotate by 270 offset 0

#unset colorbox
#load '../style.gp'
#set palette

Imin=4.433
Imax=2.675

Tmin=0.0115
Tmax=0.073

concmin=100*(Imax+log(Tmin))/(Imax-Imin)

concmax=100*(Imax+log(Tmax))/(Imax-Imin)

set log y2
set y2range [100*Tmax:100*Tmin]
set y2tics (1.2,2,4, 7)
set yrange [concmax:concmin]


list = system('ls LudoxHS40_201508_032_t_*')
p for [file in list] file.'' u ($1+5.0):(100*(Imax+log($2))/(Imax-Imin)):(file[24:26]+0.0) w lp ls 5 lt 1 pt 7 lw 3 ps 1.5 palette notitle
