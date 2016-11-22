set grid

Mmax=65.0

M5500=8.17
m5500=7.85

M8000=2.6267
m8000=2.5245

M10000=1.281
m10000=1.229

set xlabel 'Vertical Position / mm'
set ylabel 'Sucrose Mass Fraction / $\%$' offset 1

set yrange [-5:70]
set xrange [0:19]

set key sample 2 width -1 spacing 1.5

#p 'sucrose_5500eV.dat' u ($1+10):(Mmax*(m5500+log($2))/(m5500-M5500)) w l ls 1 t '5500 eV', 'sucrose_8000eV.dat' u ($1+10):(Mmax*(m8000+log($2))/(m8000-M8000)) w l ls 2 t '8000 eV'#, 'sucrose_10000eV.dat' u ($1+10):(Mmax*(m10000+log($2))/(m10000-M10000)) w l ls 3 t '10000 eV'

p 'sucrose_5500eV.dat' u ($1+10):(Mmax*(m5500+log($2))/(m5500-M5500)) w l ls 1 t '\smaller 5500 eV', 'sucrose_10000eV.dat' u ($1+10):(Mmax*(m10000+log($2))/(m10000-M10000)) w l ls 2 t '\smaller 10000 eV'
