import matplotlib as mpl
import matplotlib.patches as mpatches
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
from matplotlib.colors import ListedColormap, BoundaryNorm
import matplotlib.colors as colors
import matplotlib.cm as cmx
import matplotlib.gridspec as gridspec
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter
from matplotlib.widgets import Slider
import numpy as np
import sys,os

dir_name=os.path.dirname(os.path.realpath(__file__))

rho1=1000*0.996657*np.exp(0.0041207*21.23) #sucrose (kg/m3)
rho2=998. #water (kg/m3)
D=5.4e-10 #diffusion coefficient (m2 s-1)
L=0.02 #length of capillary (m)
z0=0.01
#t0=0.
L_pos=L
pos0=L_pos-L
z0_pos=z0+pos0

colormap_chosen='hot'
cm=plt.get_cmap(colormap_chosen)
cNorm  = colors.Normalize(vmin=0, vmax=1)
scalarMap = cmx.ScalarMappable(norm=cNorm, cmap=cm)

def rho(x,t,N):
	x=x-pos0
	rho=(rho1*z0+rho2*(L-z0))/L
	for N0 in range(1,N):
		rho+=(2./(N0*np.pi))*((rho1-rho2)*np.sin((np.pi*N0*z0)/L)+rho2*np.sin(N0*np.pi))*np.cos(np.pi*(N0)*x/L)*np.exp(-((np.pi*(N0)/L)**2*D*t))	
	return rho
	
x=np.linspace(pos0,L_pos,300)	
N=2000
limits=[]
maxtime=360 #in minutes
#time_range=np.linspace(0,maxtime*60,10)
time_range=np.logspace(1.5,4.4,12)

fig = plt.figure(figsize=(12,10))
ax1 = fig.add_axes([0.1, 0.08, 0.75, 0.85])
ax2 = fig.add_axes([0.9, 0.08, 0.035, 0.85])

cbar=mpl.colorbar.ColorbarBase(ax2,cmap=colormap_chosen,norm=colors.LogNorm(vmin=min(time_range)/3600., vmax=max(time_range)/3600.), orientation='vertical')

ax2.set_ylabel(r'Diffusion Time / h', rotation=90, labelpad=-80,fontsize=16)
ax2.set_yticks([0.01,0.1,1,2])
ax2.set_yticklabels(['0.01','0.1','1','2'])
ax2.tick_params(axis='y',which='major',labelsize=14)
ax2.grid(True)

ax1.plot(1000*x,rho(x,0.00001,2*N),linewidth=3.,color='k',linestyle='dashed')
for (i,t0) in enumerate(time_range):
	print i
	color0 = i / float(len(time_range))
	print color0,t0/3600., max(time_range)/3600.
	ax1.plot(1000*x,rho(x,t0,N),linewidth=7.,color='k')
	ax1.plot(1000*x,rho(x,t0,N),linewidth=5.,color=scalarMap.to_rgba(color0), label='%.0f  min'%int(float(t0)/60.))
	plt.draw()	
ax1.annotate(r'$\rho_{max}$', xy=(10,1088), xytext=(13,1087), ha='center', va='center',fontsize=30, bbox=dict(boxstyle='round,pad=0.2', fc=None, alpha=0.), arrowprops=dict(arrowstyle='->', connectionstyle='arc,rad=0.',color='k',linewidth=1.6))
ax1.annotate(r'$\rho_{min}$', xy=(10,998), xytext=(7,998), ha='center', va='center',fontsize=30, bbox=dict(boxstyle='round,pad=0.2', fc=None, alpha=0.), arrowprops=dict(arrowstyle='->', connectionstyle='arc,rad=0.',color='k',linewidth=1.6))

ax1.set_xlabel('Vertical Position / mm',fontsize=24)
ax1.set_ylabel(r'Density / kg m$^{-3}$',fontsize=24,labelpad=3)
ax1.set_ylim([993,1090])
ax1.tick_params(axis='both',which='major',labelsize=19)
def positions(x, pos):
	return '%.2g' % (x)	
ax1.xaxis.set_major_formatter(FuncFormatter(positions))
ax1.grid(True)

plt.savefig(dir_name+'/gradient_image.pdf',bbox_inches='tight',facecolor='None',dpi=150)
plt.show()


