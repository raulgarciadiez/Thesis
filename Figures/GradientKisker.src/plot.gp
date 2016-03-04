#load '../style.gp'

#FILENAME=system("echo $(basename $PWD)")

set log
set grid
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Shape Factor / a.u.' offset 2
set autoscale
set xrange [0.025:0.4]
set yrange [1:2e5]
set key
set xtics (0.03,0.05,0.1,0.2,0.3)

#set title FILENAME

p 'data.dat' u 1:($2/1.e13):($4/1.e13) w yerrorbars ls 2 notitle, '' u 1:($3/1.e13) w l ls 2 t 'Spherical Model','' u 1:($2/1.e13) ls 1 t 'Experimental Data'

#replot
#set output 	#Closes the temporary output files.
#!sed "s|includegraphics{temp}|includegraphics{$(basename $PWD)}|" < temp.tex > "../$(basename $PWD).tex"
#!epstopdf temp.eps --outfile="../$(basename $PWD).pdf"
