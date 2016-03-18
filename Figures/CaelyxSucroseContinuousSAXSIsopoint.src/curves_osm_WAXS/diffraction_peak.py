import time, os,re, sys,fnmatch, shutil
import numpy as np
from scipy.optimize import leastsq
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import matplotlib.cm as cmx
import matplotlib as mpl
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter
from scipy.interpolate import interp1d

def func(x,x0,dev,ratio,A,B,C):
	def func_BG(x,A,B,C):
		return A+B*np.power(x,-C)
	def func_peak(x,x0,dev):
		return dev/(np.pi*2.*(np.power(x-x0,2)+np.power(dev/2.,2)))
	return func_BG(x,A,B,C)+ratio*func_peak(x,x0,dev)
def func_peak(x,pam):
	x0=pam[0]
	dev=pam[1]
	return dev/(np.pi*2.*(np.power(x-x0,2)+np.power(dev/2.,2)))	
	
def residuals(pam,q,I,errI):	
	return (I-func(q,*pam))/errI
	
dir_name=os.path.dirname(os.path.realpath(__file__))

suffixes=[]
patterns=['curves_*_137.dat','curves_*_135.dat','curves_*_133.dat','curves_*_131.dat']
for root, dirs, files in os.walk(dir_name):
	for pattern in patterns:
		for (k,filename) in enumerate(fnmatch.filter(files, pattern)):
			y0=float(filename[7:-8])
			suffixes.append(y0)
suffixes.sort()	

qmin=1.5
qmax=3.0

p0=[2.22,.3, 8.e9,4.8e11,5.e11,2.5]
p_list=np.empty(shape=(len(suffixes),len(p0)))
cov_list=np.empty(shape=(len(suffixes),len(p0)))

for (i,suf) in enumerate(suffixes):
	try:
		filedata=np.genfromtxt('curves_%.2f_137.dat'%suf)
	except IOError:
		try:
			filedata=np.genfromtxt('curves_%.2f_135.dat'%suf)
		except IOError:	
			try:
				filedata=np.genfromtxt('curves_%.2f_133.dat'%suf)
			except IOError:	
				try:
					filedata=np.genfromtxt('curves_%.2f_131.dat'%suf)
				except IOError:	
					print 'NO file'+str(suf)
	q=filedata[:,0]
	I=filedata[:,1]
	errI=filedata[:,3]
	
	step=q[1]-q[0]
	indexmin=np.where(np.logical_and(q>=(qmin-step/2.), q<=(qmin+step/2.)))[0]
	indexmax=np.where(np.logical_and(q>=(qmax-step/2.), q<=(qmax+step/2.)))[0]
	qfit=q[indexmin:indexmax+1]
	Ifit=I[indexmin:indexmax+1]
	errIfit=errI[indexmin:indexmax+1]
	
	p,cov,infodict,mesg,ier = leastsq(residuals,p0,args=(qfit,Ifit,errIfit),full_output=True)
	p_list[i]=p
	for j in range(len(p)):
		cov_list[i][j]=cov[j][j]
	def plot(pam):
		plt.xlim([1.5,3.])
		plt.ylim([min(Ifit),max(Ifit)])
		plt.loglog(q,I)
		plt.loglog(q,func(q,*pam))
		plt.show()
	#plot(p)

colormap_chosen='autumn'
cm=plt.get_cmap(colormap_chosen)
cNorm  = colors.Normalize(vmin=0, vmax=1)
scalarMap = cmx.ScalarMappable(norm=cNorm, cmap=cm)	
x=np.linspace(1.7,2.7,1000)
for (i,ed) in enumerate(suffixes):
	edmin=min(suffixes)
	edmax=max(suffixes)
	color = (ed-edmin)/(edmax-edmin)
	plt.plot(x,func_peak(x,p_list[i][:2]),color=scalarMap.to_rgba(color))
	plt.draw()
plt.show()

filedata=np.genfromtxt('isopoint_intensity.dat')

fig, ax1 = plt.subplots()
ax2 = ax1.twinx()

color1='k'
color2='red'#'#084B8A'
colorgrey='#D8D8D8'

rect = matplotlib.patches.Rectangle((670.,0.7), 950, 1.4, color=colorgrey,alpha=0.15)
ax1.add_patch(rect)
#ax3 = fig.add_subplot(111, xlim=(750,1550), ylim=(1.05e13,2.313), autoscale_on=False, bg_color='red')

ax1.errorbar(filedata[:,0],filedata[:,1]/(1.05e12*100*0.3*0.47),yerr=filedata[:,2]/(1.05e12*100*0.3*0.47),color=color1,fmt='o')
ax1.set_xlabel('Osmolality / mOsm kg$^{-1}$',size=14)
ax1.set_ylabel('Intensity at $q=$0.122 nm$^{-1}$ / cm$^{-1}$', color=color1,size=14)
for tl in ax1.get_yticklabels():
    tl.set_color(color1)
ax1.vlines(670.,0.8,2.1,linewidth=3., linestyle='--',color=colorgrey)
ax1.set_ylim([0.8,2.1])
ax1.set_xlim([200,1550])
ax1.tick_params(axis='both',which='major',labelsize=14)


weighting=1/(np.power(np.array(cov_list[:,0]),2))
average=np.average(p_list[:,0],weights=weighting/sum(weighting))
ax2.errorbar(suffixes, 100*(average-p_list[:,0])/average,yerr=cov_list[:,0]/average,color=color2,fmt='p')
ax2.hlines(0,200,1550,color=color2,linewidth=1.5, linestyle=':')
ax2.set_ylabel(r'Diffraction peak deviation from $q=$%.3f nm$^{-1}$'%average+' / $\%$', color=color2,rotation=270, labelpad=25,size=14)
for tl in ax2.get_yticklabels():
    tl.set_color(color2)
ax2.set_ylim([-5.,2.])
ax2.tick_params(axis='both',which='major',labelsize=14)

bbox_props = dict(boxstyle="rarrow,pad=0.3", fc=colorgrey, ec="k", lw=1)
ax1.text(950, 2.01, "Osmotic Shrinkage", ha="center", va="center", rotation=0,
            size=17,
            bbox=bbox_props)
            
plt.savefig(dir_name+'/osmolality_effect.pdf', bbox_inches='tight', pad_inches=0.1,dpi=500)	
plt.savefig(dir_name+'/fig4.pdf', bbox_inches='tight', pad_inches=0.1,dpi=500)	
plt.show()


prnt

lattice_const=2*np.pi/(np.sin(np.radians(120))*p_list[:,0])
err_lattice_const=2*np.pi*cov_list[:,0]/(np.sin(np.radians(120))*p_list[:,0]**2)
weighting=1/(np.power(np.array(err_lattice_const),2)) #weighting = 1/(variance**2)
lattice_const_av=np.average(lattice_const,weights=weighting/sum(weighting)) 
plt.errorbar(suffixes, lattice_const,yerr=err_lattice_const,fmt='o')
plt.hlines(lattice_const_av,min(suffixes),max(suffixes),linewidth=3.,color='b',label='Average Lattice = (%.2f) nm'%(lattice_const_av))
plt.legend(loc=0)
plt.show()

crystal_const=4*np.pi/p_list[:,1]
err_crystal_const=4*np.pi*cov_list[:,1]/(p_list[:,1]**2)
weighting=1/(np.power(np.array(err_crystal_const),2)) #weighting = 1/(variance**2)
crystal_const_av=np.average(crystal_const,weights=weighting/sum(weighting)) 
plt.errorbar(suffixes, crystal_const,yerr=err_crystal_const,fmt='o')
plt.hlines(crystal_const_av,min(suffixes),max(suffixes),linewidth=3.,color='b',label='Average Crystal size = (%.2f) nm'%(crystal_const_av))
plt.legend(loc=0)
plt.show()

