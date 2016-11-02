
unset key
bm = 0.15
lm = 0.12
rm = 0.95
gap = 0.03
size = 0.8
y1 = 1.035; y2 = 1.078; y3 = 1.162; y4 = 1.192

set multiplot

set border 1+2+8
set xtics nomirror
set ytics nomirror
set lmargin at screen lm
set rmargin at screen rm
set bmargin at screen bm + 0.12
set tmargin at screen bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) )
set yrange[y1:y2]

set ylabel 'Density / g cm$^{-3}$' offset 1, 3

set grid
set xrange[-0.7:4.3]
set xtic rotate by -45
set ytics (1.04,1.05,1.06,1.07)

set palette model RGB defined ( 0 'red', 1 'black' )
unset colorbox

set style line 3 lt 0 lw 5# nohead nofilled size screen 0.025,30,45 lw 5 lc rgb 'grey'

#set style line 1 lw 1 lc rgb "red"

#set label 'PS-Plain'  at -0.11,1.078 tc rgb 'blue'
#set label 'PS-COOH'   at 1.8,1.164 tc rgb 'blue'
#set label 'PMMA-COOH' at 3.,1.188 tc rgb 'blue'

f(x)=1.05
g(x)=1.18

p f(x) lt 1 lw 10 lc rgb 'grey' notitle,  g(x) lt 1 lw 10 lc rgb 'cyan' notitle,'density_comp.dat' u 1:3:4:5 w yerr lt 1 lw 7 palette notitle, for [i in '5 7 13']  '' u 1:($6==i ? $3: NaN):5:xtic(2) w points pt i ps 2.5 palette notitle

set label 'PS-Plain'  at -0.11,1.162 tc rgb 'blue'
set label 'PS-COOH'   at 1.8,1.164 tc rgb 'blue'
set label 'PMMA-COOH' at 2.6,1.188 tc rgb 'blue'

unset xtics
unset xlabel
unset ylabel
set border 2+4+8
set bmargin at screen bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) ) + gap
set tmargin at screen bm + size + gap
set yrange [y3:y4]
set ytics (1.17,1.18)

p f(x) lt 1 lw 10 lc rgb 'grey' notitle,  g(x) lt 1 lw 10 lc rgb 'cyan' notitle, 'density_comp.dat' u 1:3:4:5 w yerr lt 1 lw 7 palette notitle, for [i in '5 7 13']  '' u 1:($6==i ? $3: NaN):5:xtic(2) w points pt i ps 2.5 palette notitle

set label 'Density / g cm^{-3}' font "Times,26"  at screen 0.025, bm +0.05 + 0.5 * (size + gap) offset 0,-strlen('Density / g cm^{-1}')/4.0 rotate by 90

set arrow from screen lm - gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1)+abs(y4-y3) ) ) - gap / 4.0 to screen \
lm + gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) ) + gap / 4.0 nohead

set arrow from screen lm - gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1)+abs(y4-y3) ) ) - gap / 4.0  + gap to screen \
lm + gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) ) + gap / 4.0 + gap nohead

set arrow from screen rm - gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1)+abs(y4-y3) ) ) - gap / 4.0 to screen \
rm + gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) ) + gap / 4.0 nohead

set arrow from screen rm - gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1)+abs(y4-y3) ) ) - gap / 4.0  + gap to screen \
rm + gap / 4.0, bm + size * (abs(y2-y1) / (abs(y2-y1) + abs(y4-y3) ) ) + gap / 4.0 + gap nohead

#replot

unset multiplot
