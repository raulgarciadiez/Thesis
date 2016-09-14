set log
set grid

set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Rel. Std. Deviation'

set xrange [0.07:0.5]
set yrange [0.055:1]

set xtics (0.07,0.1,0.2,0.5)
set ytics (0.1,0.2,0.5,1.)


L(x,sigma, x0, amp, C)=amp*sigma/(sigma**2+(x-x0)**2)+C      

unset key

set label '$q^{\star}_1$' at 0.09,0.09
set label '$q^{\star}_2$' at 0.15,0.06
set label '$q^{\star}_3$' at 0.22,0.05
set label '$q^{\star}_4$' at 0.28,0.06
set label '$q^{\star}_5$' at 0.35,0.12

p 'standard_deviation-2-datasets.dat' u ($1<0.15?$1:1/0):2 w p ls 1 notitle,'' every 2 u (($1<0.3&&$1>0.15)?$1:1/0):2 w p ls 1 notitle,'' every 5 u ($1>0.3?$1:1/0):2 w p ls 1 notitle , (x > 0.085 && x < 0.102)?L(x,0.00500141,0.0899763,-0.00194121,0.5061837):1/0 ls 2, (x > 0.146 && x < 0.163)?L(x,0.00642317,0.15162703,-0.0008451,0.23102536):1/0 ls 2,(x > 0.201 && x < 0.25)?L(x,0.07519201,0.22672681,-0.06072027,0.89119795):1/0 ls 2, (x > 0.262 && x < 0.31)?L(x,0.02928396,0.28218237,-0.00371312,0.24091453):1/0 ls 2, (x > 0.324 && x < 0.371)?L(x,0.38429511,0.34213846,-2.04170695,5.47744858):1/0 ls 2