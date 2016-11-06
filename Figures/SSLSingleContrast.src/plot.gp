set log
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.03:1.13]
set yrange [6.e-1:11e4]

set key at 1.05,10e4 spacing 1.3 samplen 2 width -6.5 maxrows 5
set xtics (0.03,0.05,0.1,0.2,0.5, 1, 2.)

size_list='81.4 86.8 102.7 105.2 178.9 274.1'


set style line 1  lc rgb '#0025ad' lt 1 lw 5 # --- blue
set style line 2  lc rgb '#0060ad' lt 1 lw 5 #      .
set style line 3  lc rgb '#0099ad' lt 1 lw 5 #      .
set style line 4  lc rgb '#00ad88' lt 1 lw 5 #      .
set style line 5 lc rgb '#09ad00' lt 1 lw 5 #      .
set style line 6 lc rgb '#056d00' lt 1 lw 5 # --- green

set style line 7  lc rgb '#DF0101' lt 1 lw 5 #---- red
set style line 8 lc rgb '#8A0808' lt 1 lw 5 #      .
set style line 9 lc rgb '#190707' lt 1 lw 5 # --- black


p 'DEF_HSPC_PEG_50_Oct.dat' w l ls 6 t '\smaller PEG 81 nm', 'DEF_HSPC_PEG_80_Oct.dat' u 1:($2*1.5) w l ls 5 t '\smaller PEG 87 nm', 'HSPC_PEG_80_May.dat' u 1:($2*1.3*2) w l ls 4 t '\smaller PEG 103 nm','HSPC_PEG_200_May.dat' u 1:($2*1.4*4) w l ls 2 t '\smaller PEG 179 nm', 'HSPC_PEG_400_May.dat' u 1:($2*1.6*5) w l ls 1 t '\smaller PEG 274 nm', 'DEF_HSPC_50_Oct.dat' u 1:($2*50) w l ls 7 t '\smaller plain 89 nm', 'HSPC_80_Oct.dat' u 1:($2*1.5*50) w l ls 8 t '\smaller plain 116 nm', 'DEF_HSPC_100_Oct.dat' u 1:($2*1.5*2*50) w l ls 9 t '\smaller plain 128 nm'

#p 'HSPC_PEG_50_Oct.dat' w l ls 6 t '81.4', 'HSPC_PEG_80_Oct.dat' u 1:($2*1.5) w l ls 5 t '86.8', 'HSPC_PEG_80_May.dat' u 1:($2*1.3*2) w l ls 4 t '102.7','HSPC_PEG_100_Oct.dat' u 1:($2*1.35*3) w l ls 3 t '105.2','HSPC_PEG_200_May.dat' u 1:($2*1.4*4) w l ls 2 t '178.9', 'HSPC_PEG_400_May.dat' u 1:($2*1.6*5) w l ls 1 t '274.1', 'HSPC_50_Oct.dat' u 1:($2*50) w l ls 7 t '88.77', 'HSPC_80_Oct.dat' u 1:($2*1.5*50) w l ls 8 t '116.0', 'HSPC_100_Oct.dat' u 1:($2*1.5*2*50) w l ls 9 t '127.7'


