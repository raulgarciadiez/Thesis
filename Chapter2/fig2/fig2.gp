load '../style.gp'

set grid
set xlabel 'Solvent Electron density / nm$^{-3}$'
set ylabel '$I(0)$ / a.u.'  offset 1.5
set autoscale
set xrange[334.:345.]
set yrange [-0.2:11]

a=36722668518278.6/1.e14
b=339.211
c=47807032125371.6/1.e14
f(x)=a*(x-b)**2+c

p f(x) ls 1 notitle,  'data.dat' u 1:($4/1.e14) w p ls 2 notitle

replot
set output #Closes the temporary output files.
!sed 's|includegraphics{temp}|includegraphics{Chapter1/fig2/figure}|' < temp.tex > figure.tex
!epstopdf temp.eps --outfile='figure.pdf'
