reset
set grid
set log
set xlabel 'q / nm^{-1}' font "Times,28" offset 1
set ylabel 'Scattering Intensity / a.u.' font "Times,28" offset 0.5
set autoscale
set xrange[0.3:1.11]
set yrange [0.65:2]
set key font "Times,24"
set key spacing 5
set xtic font "Times,28"
set xtics (0.3,0.5,1.)
set ytics font "Times,28"
set ytics (0.7,1.,1.5)
set bmargin 8

#set style function lines

#set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
#unset colorbox

#set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
set style arrow 1 lt 0 lw 10 lc rgb 'grey'

set arrow from 0.8,1.4 to 0.8,0.8 lw 10 lc rgb 'grey'

set label "Deformation" at 0.86,1.3 font "Helvetica, 30" tc rgb 'grey' rotate by -90


p 'SSL_PEG_50_water.dat' smooth sbezier lw 10 lc rgb 'black' t 'In buffer', 'SSL_PEG_50_sucr.dat' u 1:($2/5.) smooth sbezier lw 10 lc rgb 'red' t 'Max. osmolality'

set term push
set term postscript enhanced eps color solid "Times" 18 size 5,4.5
set out "chisq_exp_INSET.eps"
replot
set out
set term pop
! convert -density 400 chisq_exp_INSET.eps chisq_exp_INSET.pdf
! convert -density 400 chisq_exp_INSET.eps chisq_exp_INSET.svg
