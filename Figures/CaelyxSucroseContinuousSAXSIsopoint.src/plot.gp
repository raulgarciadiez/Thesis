set grid

set xlabel 'Solvent Osmolality / mOsm kg$^{-1}$'
set ylabel 'Intensity at $q=0.123$ nm$^{-1}$ / cm$^{-1}$' offset 1

N=1.05e14*0.3

osm_thres=670.

ymin=0.8
ymax=2.6

set style rect fc lt -1 fs solid 0.15 noborder
set obj rect from first osm_thres, graph 0 to graph 1, graph 1 back

set grid front

set yrange [ymin:ymax]
set xrange [150:2150]

set arrow from osm_thres,ymin to osm_thres,ymax nohead ls 2

set arrow from osm_thres,2.4 to osm_thres+400,2.4 head filled size screen 0.03,15,45 ls 2
set label '\smaller \shortstack{Osmotic\\shrinkage}' at osm_thres+100,2.2 front
set label  '\smaller \shortstack{Constant\\shape\\and size}' at osm_thres-280,2.2 front center

set key at 2200,1.2 spacing 1.5 samplen 2 width -3

set xtics (0,300,600,900,1200,1500,1800,2100)


p 'isopoint_intensity_SAXS.dat' u 1:($2/N) w p ls 1 t '\smaller SAXS', 'isopoint_intensity_WAXS.dat' u 1:($2/(N/2.1)) w p ls 3 t '\smaller WAXS', 

 
