import numpy as np
import pylab
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
import time, os,re, sys,fnmatch, shutil
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter

dir_name=os.path.dirname(os.path.realpath(__file__))

N=20. #interpolation points
Nsubs=6.5e9

class interpolate_absorption:
	def __init__(self,q,I,errI):
		self.I=I
		self.errI=errI
		self.q=1.*np.array(q)
		self.step=self.q[1]-self.q[0]
		self.new_q=np.arange(min(self.q)+self.step/2.,max(self.q)-self.step/2.,self.step/N)
		fI=interp1d(self.q,self.I,kind='linear')
		self.new_I=fI(self.new_q) 
		ferrI=interp1d(self.q,self.errI,kind='linear')
		self.new_errI=ferrI(self.new_q)	

filename=dir_name+'/curve_345.4-1.dat'
#filename=dir_name+'/curve_346.5-2.dat'
filedata=np.genfromtxt(filename) 
qexp=filedata[:,0]
Iexp=filedata[:,1]
errIexp=filedata[:,3]

filename_bg=dir_name+'/water_capillary_rect2.dat'
filedata_bg=np.genfromtxt(filename_bg) 
q_bg=filedata_bg[:,0]
I_bg=filedata_bg[:,1]
errI_bg=filedata_bg[:,3]

filenametest=dir_name+'/curve_334.02-1.dat'
filedatatest=np.genfromtxt(filenametest) 
qtest=filedatatest[:,0]
Itest=filedatatest[:,1]

class_interpol=interpolate_absorption(q_bg,I_bg,errI_bg) #interpolation of background
q_bg,I_bg,errI_bg,step=class_interpol.new_q,class_interpol.new_I,class_interpol.new_errI, class_interpol.step #new interpolated q_bg, I_bg, errI_bg, step

qsubs=list()
Isubs=list()
errIsubs=list()
for (i,q) in enumerate(qexp):
	if q<1.145 and q>0.026:
		I=Iexp[i]
		index=np.where(np.logical_and(q+step/N>q_bg,q-step/N<q_bg))[0][0]
		Ibg=I_bg[index]
		if q>0.4 and i%12==0:
			qsubs.append(q)
			Isubs.append(I-Nsubs*Ibg)
			errIsubs.append(np.power((errIexp[i])**2+(Nsubs*errI_bg[index])**2,0.5))		
		elif q>0.3 and i%5==0:
			qsubs.append(q)
			Isubs.append(I-Nsubs*Ibg)
			errIsubs.append(np.power((errIexp[i])**2+(Nsubs*errI_bg[index])**2,0.5))
		elif q>0.18 and i%2==0:
			qsubs.append(q)
			Isubs.append(I-Nsubs*Ibg)
			errIsubs.append(np.power((errIexp[i])**2+(Nsubs*errI_bg[index])**2,0.5))	
		elif q<=0.18:
			qsubs.append(q)
			Isubs.append(I-Nsubs*Ibg)
			errIsubs.append(np.power((errIexp[i])**2+(Nsubs*errI_bg[index])**2,0.5))
	else:
		pass	
#CREATION OF THE PLOT

result=np.empty(shape=(len(Isubs),3))
result[:,0]=qsubs
result[:,1]=Isubs
result[:,2]=errIsubs

np.savetxt('curve_BG_subtracted.dat',result)

prnt

params = {'legend.fontsize': 20,
          'legend.linewidth': 2}
pylab.rcParams.update(params)	
	
fig = plt.figure(figsize=(12,10))
ax1 = fig.add_axes([0.1, 0.1, .85, .85])

#ax1.plot(qtest,Itest/1.e22,linewidth=7.)	
ax1.plot(qexp,Iexp/1.e22,linewidth=7.,color='r',label=r'$\rho_{solv}=345.4$ nm$^{-3}$')
ax1.plot(q_bg,Nsubs*I_bg/1.e22,linestyle='--',linewidth=5.,label='Experimental Background',color='grey')
ax1.scatter(qsubs,np.array(Isubs)/1.e22,linewidth=3.,color='k',label='Background Corrected')
ax1.errorbar(qsubs,np.array(Isubs)/1.e22,yerr=np.array(errIsubs)/1.e22,linewidth=3.,color='k',linestyle="None")
#ax1.legend(loc=0)
ax1.set_yscale('log')
ax1.set_xscale('log')
qmin=0.034
qmax=0.68
ax1.set_xlim([qmin,qmax])
ax1.set_ylim([0.3,30])	
ax1.set_xlabel(r'$q$ / nm$^{-1}$',fontsize=24)
ax1.set_ylabel('Scattering Intensity / a.u.',fontsize=24,labelpad=-10)
#ax1.annotate('Contrast matched', xy=(0.045,15), xytext=(40,-150),textcoords='offset points', ha='center', va='bottom',fontsize=20, bbox=dict(boxstyle='round,pad=0.2', fc=None, alpha=0.), arrowprops=dict(arrowstyle='->', connectionstyle='arc,rad=0.',color='k',linewidth=1.6))
ax1.grid(True)
ax1.tick_params(axis='both',which='major',labelsize=19)
def positions(x, pos):
			return '%.2g' % (x/100.)
		
ax1.yaxis.set_major_formatter(FuncFormatter(positions))
ax1.set_xticks([0.05,0.1,0.2,0.5])
ax1.set_xticklabels(['0.05','0.1','0.2','0.5'])
ax1.set_yticks([1,0.3,10,30,3])
ax1.set_yticklabels(['0.01','0.003','0.1','0.3','0.03'])
name_fig='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures/fig2B.png'
name_fig2=dir_name+'/fig_bg.pdf'
try:
	os.remove(name_fig)
	os.remove(name_fig2)
	os.remove(name_fig[:-4]+'.svg')
	os.remove(name_fig[:-4]+'.pdf')	
except OSError:
	pass
plt.savefig(name_fig, transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(name_fig2, transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(name_fig[:-4]+'.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)	
plt.savefig(name_fig[:-4]+'.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
#plt.show()







