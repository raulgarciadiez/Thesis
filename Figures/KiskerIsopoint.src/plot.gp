set multiplot

set log
set grid

set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Rel. Std. Deviation'

set xrange [0.07:0.5]
set yrange [0.055:1]

set xtics (0.07,0.1,0.2,0.5)
set ytics (0.1,0.2,0.5,1.)


set size 1,1
set origin 0,0

L(x,sigma, x0, amp, C)=amp*sigma/(sigma**2+(x-x0)**2)+C      

unset key

set label 1 '$q^{\star}_1$' at 0.075,0.115
set label 2 '$q^{\star}_2$' at 0.125,0.1
set label 3 '$q^{\star}_3$' at 0.18,0.085
set label 4 '$q^{\star}_4$' at 0.31,0.1
set label 5 '$q^{\star}_5$' at 0.365,0.135

xmin=0.085
xmax=0.095
ymin=0.08
ymax=0.3

### This is to plot the square. You can skip this ###
set arrow 1 from xmax,0.28 to 0.192,0.45 lw 1 lc rgb 'black' back filled
set arrow 2 from xmin,ymin to xmax,ymin lw 3 lt 2  lc rgb 'black' front nohead
set arrow 3 from xmin,ymax to xmax,ymax lw 3 lt 2 lc rgb 'black' front nohead
set arrow 4 from xmin,ymax to xmin,ymin lw 3 lt 2 lc rgb 'black' front nohead
set arrow 5  from xmax,ymax to xmax,ymin lw 3 lt 2 lc rgb 'black' front nohead



set object 1 rect from 0.23,0.3 to 0.5,1
set object 1 rect fc rgb 'white' fillstyle solid 0.0 noborder #front

set label '$\Delta q$' at 0.295,0.7 front

p 'standard_deviation-2-datasets.dat' u ($1<0.15?$1:1/0):2 w p ls 1 notitle,'' every 2 u (($1<0.3&&$1>0.15)?$1:1/0):2 w p ls 1 notitle,'' every 5 u ($1>0.3?$1:1/0):2 w p ls 1 notitle , (x > 0.085 && x < 0.102)?L(x,0.00500141,0.0899763,-0.00194121,0.5061837):1/0 ls 2, (x > 0.146 && x < 0.163)?L(x,0.00642317,0.15162703,-0.0008451,0.23102536):1/0 ls 2,(x > 0.201 && x < 0.25)?L(x,0.07519201,0.22672681,-0.06072027,0.89119795):1/0 ls 2, (x > 0.262 && x < 0.31)?L(x,0.02928396,0.28218237,-0.00371312,0.24091453):1/0 ls 2, (x > 0.324 && x < 0.371)?L(x,0.38429511,0.34213846,-2.04170695,5.47744858):1/0 ls 2


################################################### 2nd plot

set size 0.47,0.45
set origin 0.475,0.525
unset logscale xy
unset xlabel
unset ylabel
unset grid
unset object 1
unset label 1
unset label 2
unset label 3
unset label 4
unset label 5

unset arrow 1
unset arrow 2
unset arrow 3
unset arrow 4
unset arrow 5

set xrange [xmin:xmax]
set yrange [ymin:ymax]



set xtics (0.085,0.09,0.095)
set ytics (0.1,0.2)
set ytics format '\smaller %g' offset 0.5
set xtics format '\smaller %g' offset 0, 0.25



set arrow from 0.087,0.22 to 0.093,0.22 ls 2 nohead 

p 'standard_deviation-2-datasets.dat' u ($1<0.15?$1:1/0):2 w l ls 1 not, "<echo '0.0899 0.11'" w p ls 1 lc rgb 'black'




unset multiplot