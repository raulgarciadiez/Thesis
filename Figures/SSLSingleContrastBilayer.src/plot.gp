set terminal epslatex size 7cm,11cm color colortext





set log
set grid
set xlabel '$q$ / nm$^{-1}$' 
set ylabel 'Scattering Intensity / a.u.' offset 2,-1
set autoscale
set xrange [0.35:2.]
set yrange [6.e-1:4e2]
#set key font "Times,18"
#set key spacing 1.2
#set key 0.09,20
#set xtics font "Helvetica,20"
set xtics (0.5, 1, 2.)
#set ytics font "Helvetica,20" 

size_list='81.4 86.8 102.7 105.2 178.9 274.1'


set style line 1  lc rgb '#0025ad' lt 1 lw 5 # --- blue
set style line 2  lc rgb '#0060ad' lt 1 lw 5 #      .
set style line 3  lc rgb '#0099ad' lt 1 lw 5 #      .
set style line 4  lc rgb '#00ad88' lt 1 lw 5 #      .
set style line 5 lc rgb '#00ad4e' lt 1 lw 5 #      .
set style line 6 lc rgb '#09ad00' lt 1 lw 5 # --- green

set style line 7  lc rgb '#DF0101' lt 1 lw 5 #---- red
set style line 8 lc rgb '#8A0808' lt 1 lw 5 #      .
set style line 9 lc rgb '#190707' lt 1 lw 5 # --- black


#p 'HSPC_PEG_50_Oct.dat' w l ls 6 t '81.4', 'HSPC_PEG_80_Oct.dat' u 1:($2*1.5) w l ls 5 t '86.8', 'HSPC_PEG_80_May.dat' u 1:($2*1.3*2) w l ls 4 t '102.7','HSPC_PEG_100_Oct.dat' u 1:($2*1.35*3) w l ls 3 t '105.2','HSPC_PEG_200_May.dat' u 1:($2*1.4*4) w l ls 2 t '178.9', 'HSPC_PEG_400_May.dat' u 1:($2*1.6*5) w l ls 1 t '274.1', 'HSPC_50_Oct.dat' u 1:($2*50) w l ls 7 t '88.77', 'HSPC_80_Oct.dat' u 1:($2*1.5*50) w l ls 8 t '116.0', 'HSPC_100_Oct.dat' u 1:($2*1.5*2*50) w l ls 9 t '127.7'


p 'HSPC_PEG_80_May.dat' u 1:($2*1.3*2-1) w l ls 4 t 'PEG 103 nm','HSPC_PEG_200_May.dat' u 1:($2*1.4*4-2.63) w l ls 2 t 'PEG 179 nm', 'HSPC_PEG_400_May.dat' u 1:($2*1.6*8-6) w l ls 1 t 'PEG 274 nm', 'HSPC_50_sucr_WAXS.dat' u 1:($2*25) w l ls 7 t 'plain 89 nm', 'HSPC_100_sucr_WAXS.dat' u 1:($2*1.5*2*10) w l ls 9 t 'plain 128 nm'

#p 'HSPC_PEG_50_Oct.dat' w l ls 6 t '81.4', 'HSPC_PEG_80_Oct.dat' u 1:($2*1.5) w l ls 5 t '86.8', 'HSPC_PEG_80_May.dat' u 1:($2*1.3*2) w l ls 4 t '102.7','HSPC_PEG_100_Oct.dat' u 1:($2*1.35*3) w l ls 3 t '105.2','HSPC_PEG_200_May.dat' u 1:($2*1.4*4) w l ls 2 t '178.9', 'HSPC_PEG_400_May.dat' u 1:($2*1.6*5) w l ls 1 t '274.1', 'HSPC_50_Oct.dat' u 1:($2*50) w l ls 7 t '88.77', 'HSPC_80_Oct.dat' u 1:($2*1.5*50) w l ls 8 t '116.0', 'HSPC_100_Oct.dat' u 1:($2*1.5*2*50) w l ls 9 t '127.7'



#set term postscript enhanced eps color solid "Times" 18 size 3,5

#set size ratio 2




