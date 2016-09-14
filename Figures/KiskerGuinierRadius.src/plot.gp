set xlabel 'Solvent electron density / nm$^{-3}$' 
set ylabel '$R_g^2$ / nm$^2$'

set grid

set yrange [500:3300]
set xrange [330:370]

f(x)=R2+A/(rho0-x) #function to fit radius of gyration vs solvent electron density without considering excentricity
R2=1522.5	
A=4470.2	
rho0=343.74

set arrow from rho0,500 to rho0, 3300 nohead ls 3 

unset key

set label '$\rho_0$' at 345,3000
set label '$\tilde R^2_{g,c}$' at 365,1700

p f(x) ls 2, 'guinier-radius-results.dat' w p ls 1,  R2 ls 3

