set xlabel 'Solvent electron density / nm$^{-3}$'
set ylabel 'Deviation from $I(0)$ / $\%$

set xrange [333:361.5]
set yrange [-44:62]

set grid

p '<paste guinier-radius-results_Form_factor_norm_sort.dat guinier-radius-results_Guinier_approach_norm_sort.dat guinier-radius-results-First_point_norm_sort.dat' u 1:(100.*($4-$2)/$2) w p ls 1 t 'Guinier approximation', '' u 1:(100.*($6-$2)/$2) w p ls 2 t 'Lowest available $q$' 
