set xlabel '$q$ / nm$^{-1}$' offset 0,0.3
set ylabel 'Scattering Intensity / a.u.' offset 2
set autoscale
set grid
set xrange [0.0285:0.4]
set xtics (0.03,0.05,0.1,0.2,0.4)
set log

p 'hdf_fcm_201412_217_Sam_24.8.dat' u 1:($2/1.e12) w l ls 1 lc rgb 'black' t 'PS-COOH', 'hdf_fcm_201412_217_Sam_47.2.dat' u 1:($2/1.e12) w l ls 1 lc rgb '#510505' t '0.5 mg/ml IgG', 'hdf_fcm_201412_217_Sam_43.3.dat' u 1:($2/1.e12) w l ls 1 lc rgb '#9A0707' t '1 mg/ml IgG', 'hdf_fcm_201412_218.dat' u 1:($2/1.e12) w l ls 1 lc rgb '#C40808' t '2 mg/ml IgG', 'hdf_fcm_201412_217_Sam_21.3.dat' u 1:($2/1.e12) w l ls 1 lc rgb '#FC0606' t '4 mg/ml IgG'#, 'hdf_fcm_201412_217_Sam_51.2.dat' u 1:($2/1.e12) w l ls 1 lc rgb 'blue' t '4 mg/ml IgG (S1A)'