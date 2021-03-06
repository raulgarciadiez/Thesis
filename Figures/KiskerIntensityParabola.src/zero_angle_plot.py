from operator import itemgetter 
import os,fnmatch
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from scipy.optimize import leastsq

dir_name=os.path.dirname(os.path.realpath(__file__))
def h(x,A,B):
	return A*np.power((x-B),2)

def residuals_I0(pam,x,Y,errY):
	return (Y-h(x,pam[0],pam[1]))/errY
	
p0=[7.e-2,347.]	

filedata=np.genfromtxt('guinier-radius-results.txt')

x=filedata[:,0] #electron density
y=filedata[:,3]/1.e25 #I0
erry=np.power(y,0.5)#filedata[:,4]/1.e25 #error I0
p_total,cov_total,infodict_total,mesg_total,ier_total = leastsq(residuals_I0,p0,args=(x,y,erry),full_output=True)

print p_total

x2=filedata[:,0]*1.e27*2.82e-15 #electron density in 1/m3, multiplication by thomson radius
x2_plot=np.linspace(min(x2)-1,max(x2)+1,200)
y2=filedata[:,3]/(0.43*2.7e19) #I0 / (Transmission * Calibration Factor)
erry2=np.power(y2,0.5) #error I0
p_total2,cov_total2,infodict_total,mesg_total,ier_total = leastsq(residuals_I0,[1.e-12,1.e15],args=(x2,y2,erry2),full_output=True)

print p_total2

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(x2,y2,linewidth=2.,color='r',marker='D')
ax.plot(x2_plot,h(x2_plot,*p_total2),linewidth=2.5,color='k')

ax.set_ylim([-10000,1.22e6])
ax.set_xlabel(r'$Solvent\,scattering\,length\,density$ / m$^{-2}$',fontsize=17)
ax.set_ylabel(r'$\frac{d\sigma}{d\Omega}(q=0)$ / m$^{-1}$',fontsize=17)
ax.grid(True)

plt.savefig(dir_name+'/calibrated_parabola.png', transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(dir_name+'/calibrated_parabola.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.savefig(dir_name+'/calibrated_parabola.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)

plt.show()

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(x,y,linewidth=2.,color='r',marker='D')
ed_plot=np.arange(min(x)-1,max(x)+1,0.1)
ax.plot(ed_plot,h(ed_plot,*p_total),linewidth=2.5,color='k')
ax.set_xlabel(r'Solvent electron density / nm$^{-3}$',fontsize=17)
ax.set_ylabel(r'$I(0)$ / a.u.',fontsize=17)
ax.grid(True)
ax.set_ylim([-0.1,1.6])
ax.set_xlim([333,361])
ax.tick_params(axis='both',which='major',labelsize=13.5)

directory='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures'
try:
	os.remove(directory+'/fig6.png')
	os.remove(directory+'/fig6.svg')	
	os.remove(directory+'/fig6.pdf')
except OSError:
	pass
plt.savefig(directory+'/fig6.png', transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(directory+'/fig6.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.savefig(directory+'/fig6.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)
print p_total
plt.show()
