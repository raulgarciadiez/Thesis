reset

#set log
#unset log cb
set grid
set xlabel 'Sucrose Mass Fraction / %' font "Times,28"
set ylabel 'Deviation from q^{*} intensity / %' font "Times,28" offset 2
set autoscale
set xrange [0.0:12]
set yrange [-0.1:3]

#set key spacing 1.5
set key 4.2,2.95
#set xtics (0.05,0.1,0.2,0.5,1.)

#set cblabel 'Sucrose Concentration / %' offset -1,0  rotate by -90


set style line 1  lc rgb '#0025ad' lt 1 lw 3 # --- blue
set style line 2  lc rgb '#0060ad' lt 1 lw 3 #      .
set style line 3  lc rgb '#0099ad' lt 1 lw 3 #      .
set style line 4  lc rgb '#00ad88' lt 1 lw 3 #      .
set style line 5 lc rgb '#00ad4e' lt 1 lw 3 #      .
set style line 6 lc rgb '#09ad00' lt 1 lw 3 # --- green

N_list='10.0 9.0 850. 83.'
files='50 80 100 200'
sizes='81.4 86.8 102.7 178.9'

p for [i=1:4] 'isopoint_intensity_'.word(files,i).'.txt' u 1:(i/2.+($2-word(N_list,i))/word(N_list,i)) w lp ls (7-i) pt 7 ps 1.5 t ''.word(sizes,i)
