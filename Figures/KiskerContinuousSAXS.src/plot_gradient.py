import numpy as np
import time, os, sys,fnmatch
import pylab 
import matplotlib as mpl
from scipy.optimize import leastsq
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter
from operator import itemgetter
from scipy.interpolate import interp1d
sys.path.append('/home/rgarciad/Dokumente/Programs SAXS/AutoSAXS-python/SAXSTools/src')
import saxstools as ST

import matplotlib.colors as colors
import matplotlib.cm as cmx
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter


dir_name=os.path.dirname(os.path.realpath(__file__))
def find_suffixes():
	suffixes=[]
	pattern='hdf_*.dat'	
	for root, dirs, files in os.walk(dir_name):
		for (k,filename) in enumerate(fnmatch.filter(files, pattern)):
			pos=float(filename[23:-4])
			if pos!=1.5:
				suffixes.append(pos+5.5)
	return sorted(suffixes)
	
def find_suffixes2():
	suffixes=[]
	pattern='curve_*-1.dat'	
	for root, dirs, files in os.walk(dir_name):
		for (k,filename) in enumerate(fnmatch.filter(files, pattern)):
			ed=float(filename[6:-6])
			if ed!=355.77 and ed!=336.88:
				suffixes.append(ed)
	return sorted(suffixes,reverse=True)		

#import data
def open_data(suffix):
	def new_q(qmin,qmax,q,I,errI):
		for i in range(len(q)):
			if qmin<q[0]:
				i_min=1
				break
			elif q[i]>=qmin:
				i_min=i
				break
			else:
				pass
		for i in range(len(q)):
			if qmax>=q[-1]:
				i_max=-1
				break
			elif q[i]>=qmax:
				i_max=i
				break
			else:
				pass
		return q[i_min:i_max+1],I[i_min:i_max+1],errI[i_min:i_max+1]
		
	#suffix=str(suffix-5.5)
	#name=dir_name+'/hdf_fcm_201403_060_Sam_'+suffix+'.dat'
	suffix=str(suffix)
	try:
		name=dir_name+'/curve_'+suffix+'-1.dat'
		filedata=np.genfromtxt(name)
	except IOError:
		try:
			name=dir_name+'/curve_'+suffix+'-2.dat'
			filedata=np.genfromtxt(name)
		except IOError:
			pass
	q=filedata[:,0]
	Iexp=filedata[:,1]
	errI=filedata[:,3]
	q,Iexp,errI=new_q(qmin,qmax,q,Iexp,errI) #SELECTING RANGE OF FITTING
	return q,Iexp,errI


suffixes=find_suffixes()
ed=find_suffixes2()
ed2=sorted(ed)
suffixes2=sorted(suffixes,reverse=True)

#ednew=np.linspace(min(ed2)+0.1,max(ed2)-0.1,50*len(ed2))
#fsuffixes=interp1d(ed2,suffixes2,kind='linear')

#ed_list_labels= [334.02,336,341,354,360]
#ed_list=map(lambda x: fsuffixes(x)/9.5, ed_list_labels)
#ed_list_labels=map(lambda x: '%i'%x, ed_list_labels)


qmin=0.034
qmax=0.68

#colormap_chosen='jet'
colormap_chosen = mpl.colors.LinearSegmentedColormap.from_list('mycolors',['blue','yellow','yellow','#F7F8E0','yellow','red','#8A0808'])

fig = plt.figure(figsize=(12,10))
ax1 = fig.add_axes([0.1, 0.08, 0.85, 0.9])
ax2 = fig.add_axes([0.88, 0.26, 0.04, 0.69])

cbar=mpl.colorbar.ColorbarBase(ax2,cmap=colormap_chosen,norm=plt.normalize(vmin=min(ed), vmax=max(ed)),orientation='vertical')

ax2.set_ylabel(r'Electron Density / nm$^{-3}$',fontsize=24,labelpad=-110)
ax2.tick_params(axis='both',which='major',labelsize=19,pad=10)
ax2.grid(True)
ax2.yaxis.tick_left()
#ax2.yaxis.set_ticks(np.arange(0,1,.1))
#ax2.set_yticks(np.arange(335.,361.,5.))

#ax3 = ax2.twinx()
#ax3.set_ylabel('Vertical Position / mm',labelpad=-95,fontsize=19)
#ax3.set_yticks(ed_list)
#ax3.set_yticklabels(ed_list_labels)
#ax3.tick_params(axis='both',which='major',labelsize=15)

cm=plt.get_cmap(colormap_chosen)
cNorm  = colors.Normalize(vmin=0, vmax=1)
scalarMap = cmx.ScalarMappable(norm=cNorm, cmap=cm)
for (i,suf) in enumerate(ed2):
	A=max(ed)-min(ed)
	color=(suf-min(ed))/A# / float(len(ed))
	print suf,color
	q,I,errI=open_data(suf)
	ax1.loglog(q,I/1.e22,color='black',linewidth=3.3,zorder=1)
	ax1.loglog(q,I/1.e22,color=scalarMap.to_rgba(color),linewidth=2.,zorder=1)
	plt.draw()
filedata_bg=np.genfromtxt('water_capillary_rect2.dat')
ax1.loglog(filedata_bg[:,0],6.5e9*filedata_bg[:,1]/1.e22,color='grey',linewidth=2.5,zorder=-1,linestyle='--',dashes=(15,8))	
	
ax1.set_xlim([qmin,qmax])
ax1.set_ylim([0.6,1000])	
ax1.set_xlabel(r'$q$ / nm$^{-1}$',fontsize=24)
ax1.set_ylabel('Scattering Intensity / a.u.',fontsize=24,labelpad=-10)
#ax1.annotate('Contrast matched', xy=(0.045,15), xytext=(40,-150),textcoords='offset points', ha='center', va='bottom',fontsize=20, bbox=dict(boxstyle='round,pad=0.2', fc=None, alpha=0.), arrowprops=dict(arrowstyle='->', connectionstyle='arc,rad=0.',color='k',linewidth=1.6))
#ax1.grid(True)
ax1.tick_params(axis='both',which='major',labelsize=19)
def positions(x, pos):
			return '%.2g' % (x/100.)
		
ax1.yaxis.set_major_formatter(FuncFormatter(positions))
ax1.set_xticks([0.05,0.1,0.2,0.5])
ax1.set_xticklabels(['0.05','0.1','0.2','0.5'])
name_fig='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures/fig2.png'
try:
	os.remove(name_fig)
	os.remove(name_fig[:-4]+'.svg')
	os.remove(name_fig[:-4]+'.pdf')	
except OSError:
	pass
plt.savefig(name_fig, transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(name_fig[:-4]+'.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)	
plt.savefig(name_fig[:-4]+'.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
#plt.show()
plt.clf()

	
	

