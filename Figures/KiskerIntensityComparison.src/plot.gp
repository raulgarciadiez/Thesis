set xlabel 'Solvent electron density / nm$^{-3}$'
set ylabel 'Deviation from $I(0)$ / $\%$

set xrange [333:361.5]
set yrange [-44:62]

set grid

set key samplen 2 width -5 spacing 1.5

p '<paste guinier-radius-results_Form_factor_norm_sort.dat guinier-radius-results_Guinier_approach_norm_sort.dat guinier-radius-results-First_point_norm_sort.dat' u 1:(100.*($4-$2)/$2) w p ls 1 t '\smaller Guinier approximation', '' u 1:(100.*($6-$2)/$2) w p ls 2 t '\smaller Lowest available $q$' 
