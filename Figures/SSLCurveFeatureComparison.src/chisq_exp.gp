reset
set grid
set log
set xlabel 'q / nm^{-1}' font "Times,28" offset 1
set ylabel 'Scattering Intensity / a.u.' font "Times,28" offset 0.5
set autoscale
set xrange[0.03:1.12]
set yrange [0.5:2000]
set key font "Times,24"
set key spacing 5
set xtic font "Times,28"
set xtics (0.03,0.05,0.1,0.2,0.3,0.5,1.)
set ytics font "Times,28"
set bmargin 8

#set style function lines

#set palette model RGB defined ( 0 'red', 1 'black', 2 'blue' )
#unset colorbox

#set style arrow 1 nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'
#set style line 1 lt 0 lw 5# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

#set arrow from -4.5,143.98 to 6.,143.98 lt 1

#set label "Osmotic Shrinkage" at 0.022,200 font "Helvetica, 24" tc rgb '#6D6AD1'


p 'SSL_PEG_50_water.dat' w l lw 10 lc rgb 'black' t 'In buffer', 'SSL_PEG_50_sucr.dat' w l lw 10 lc rgb 'red' t 'Max. osmolality'

set term push
set term postscript enhanced eps color solid "Times" 18 size 5,4.5
set out "chisq_exp.eps"
replot
set out
set term pop
! convert -density 400 chisq_exp.eps chisq_exp.pdf
! convert -density 400 chisq_exp.eps chisq_exp.svg
