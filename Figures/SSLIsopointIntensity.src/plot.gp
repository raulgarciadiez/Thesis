
set grid
set xlabel 'Sucrose Mass Fraction / $\%$'
set ylabel 'Deviation from $q^{\star}$ intensity / $\%$' offset 1
set autoscale
set xrange [0.0:20]
set yrange [-0.7:5.8]

#set key 17.5, 5.

set style line 1  lc rgb '#0025ad' lt 1 lw 3 # --- blue
set style line 2  lc rgb '#0060ad' lt 1 lw 3 #      .
set style line 3  lc rgb '#0099ad' lt 1 lw 3 #      .
set style line 4  lc rgb '#00ad88' lt 1 lw 3 #      .
set style line 5 lc rgb '#00ad4e' lt 1 lw 3 #      .
set style line 6 lc rgb '#09ad00' lt 1 lw 3 # --- green

set style line 7  lc rgb '#DF0101' lt 1 lw 3 #---- red
#set style line 8 lc rgb '#8A0808' lt 1 lw 3 #      .
set style line 8 lc rgb '#190707' lt 1 lw 3 # --- black

N_list='5.5 19.0'
files='50 100'
sizes='88.8 127.7'

N_list_PEG='10.0 9.0 850. 83.'
files_PEG='50 80 100 200'
sizes_PEG='81.4 86.8 102.7 178.9'

p 'isopoint_intensity_plain_50.dat' u 1:(($2-word(N_list,1))/word(N_list,1)) w lp ls (6+1) pt 7 ps 1.5 t 'plain - '.word(sizes,1).' nm', 'isopoint_intensity_80.dat' u 1:(($2-word(N_list_PEG,2))/word(N_list_PEG,2)) w lp ls (7-2) pt 7 ps 1.5 t 'PEG - '.word(sizes_PEG,2).' nm'





#p for [i=1:4] 'isopoint_intensity_'.word(files,i).'.txt' u 1:(i/2.+($2-word(N_list,i))/word(N_list,i)) w lp ls (7-i) pt 7 ps 1.5 t ''.word(sizes,i)

#p for [i=1:2] 'isopoint_intensity_plain_'.word(files,i).'.dat' u 1:(i+($2-word(N_list,i))/word(N_list,i)) w lp ls (6+i) pt 7 ps 1.5 t ''.word(sizes,i)
