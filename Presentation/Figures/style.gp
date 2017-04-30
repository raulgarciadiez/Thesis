
set size 1,1

set term push
set term postscript enhanced eps color solid "Times" 28

set key font "Times,24"
set key spacing 5

set tics font "Times,22"

set ylabel offset 4


set style line 1 lc rgb "red" lw 3 pt 6 lt 1 ps 1.5	#pointype empty circles
set style line 2 lc rgb "black" lw 3 pt 5 lt 1	ps 1.5	#pointype squares
set style line 3 lc rgb "blue" lw 3 pt 7 lt 1 ps 1.5	#pointype filled circles
set style line 4 lc rgb "grey" lw 3 pt 13 lt 1 ps 1.5	#pointype rombos

set style line 5 lc rgb "red" lw 1 pt 6 lt 1 ps 2	#pointype empty circles


#set palette rgb 30,31,32
set palette rgb 33,13,10
