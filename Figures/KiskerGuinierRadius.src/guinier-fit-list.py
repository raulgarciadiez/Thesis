from operator import itemgetter 
import os,fnmatch
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from scipy.optimize import leastsq
import math as m
from scipy.integrate import quad

dir_name=os.path.dirname(os.path.realpath(__file__))

R=49.7
pd=22.8
R0=44.2
nu=R0/R
ed_core=339.7
ed_shell=361.9
ed_avg0=(nu**3)*ed_core+(1-nu**3)*ed_shell
	
Rmax=200.	
r_list=np.arange(0.501,Rmax,0.1)		
def Rc2(R,pd): #radius of gyration quadrat
	def g(r,R0,pd):
		def gauss(r,R0,pd):
			sigma=(pd/100)*(R0)/2.3548
			return (1/sigma)*m.exp(-((r-R0)**2)/(2*sigma**2))
		return gauss(r,R0,pd)/(quad(gauss,0,np.inf,args=(R0,pd))[0])		
	summation1=0.
	for i in r_list:
		summation1+=np.power(i,8)*g(i,R,pd)
	summation2=0.
	for i in r_list:
		summation2+=np.power(i,6)*g(i,R,pd)				
	return summation1/summation2
	
def alpha_eff(R,pd):
	def g(r,R0,pd):
		def gauss(r,R0,pd):
			sigma=(pd/100)*(R0)/2.3548
			return (1/sigma)*m.exp(-((r-R0)**2)/(2*sigma**2))
		return gauss(r,R0,pd)/(quad(gauss,0,np.inf,args=(R0,pd))[0])		
	summation1=0.
	for i in r_list:
		summation1+=((4*np.pi)**2/15.)*np.power(i,8)*((ed_core-ed_avg0)*nu**5+(ed_shell-ed_avg0)*(1-nu**5))*g(i,R,pd)
	summation2=0.
	for i in r_list:
		summation2+=(4*np.pi/3)**2*np.power(i,6)*g(i,R,pd)				
	return (3/5.)*summation1/summation2

#function to fit radius of gyration vs solvent electron density
def func_fit(Rc2,alpha_eff,sol):
	return Rc2+alpha_eff/(ed_avg0-sol)

def g(x,R2,A,C): #without considering excentricity
	return R2+A/(C-x)

p0=[37**2,4500,346.] 

filedata=np.genfromtxt('guinier-radius-results.txt')
x=filedata[:,0] #electron density
y=filedata[:,1] #radius of gyration
erry=filedata[:,2] #error

xfit=x
yfit=y
erryfit=erry

def limit_range(xfit,yfit,erryfit): #limiting the fitting range
	ed_min=340.3
	ed_max=342.7
	ind_bad=np.where(np.logical_and(x<=ed_max,x>=ed_min))[0] 
	xfit=np.delete(x,ind_bad)
	yfit=np.delete(y,ind_bad)
	erryfit=np.delete(erry,ind_bad)

	ed_min2=345.
	ed_max2=349.
	ind_bad2=np.where(np.logical_and(xfit<=ed_max2,xfit>=ed_min2))[0] 
	xfit=np.delete(xfit,ind_bad2)
	yfit=np.delete(yfit,ind_bad2)
	erryfit=np.delete(erryfit,ind_bad2)
	return xfit,yfit, erryfit
	
#xfit,yfit,erryfit=limit_range(xfit,yfit,erryfit)	

popt,pcov=opt.curve_fit(g, xfit, yfit, p0,maxfev=100000)
print (5/3.*popt[0])**0.5, popt[-1]
print (5/3.*pcov[0][0])**0.5, pcov[-1][-1]

xplot1=np.arange(min(x)-4,343.,0.05)
xplot2=np.arange(344.,max(x)+4,0.05)
fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(xplot1,g(xplot1,*popt),linewidth=2,color='k')
ax.plot(xplot2,g(xplot2,*popt),linewidth=2,color='k')
ax.scatter(xfit,yfit,linewidth=2.,marker='D',color='r')

#Rc2=Rc2(R,pd)
#print Rc2**0.5
#alpha_eff=alpha_eff(R,pd)
#plt.plot(xplot,func_fit(Rc2,alpha_eff,xplot),label='Sim',color='b') #theoretical

ax.grid(True)
ax.set_xlabel(r'Solvent electron density / nm$^{-3}$',fontsize=17)
ax.set_ylabel(r'$R_g^2$ / nm$^2$',fontsize=17)
miny=500
maxy=3400.
ax.vlines(popt[-1],miny,maxy,linestyle='--',color='b')
ax.annotate(r'$\rho_0$',xy=(popt[-1],3200.),xycoords='data',xytext=(344.2,3200.),fontsize=19)
ax.hlines(popt[0],min(xplot1),max(xplot2),linestyle='--',color='b')
ax.annotate(r'$\tilde R_{g,c}^2$',xy=(popt[-1],1600.),xycoords='data',xytext=(360.8,1600.),fontsize=19)
ax.set_ylim([miny,maxy])
ax.set_xlim([min(xplot1),max(xplot2)])
ax.tick_params(axis='both',which='major',labelsize=13.5)

directory='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures'
try:
	os.remove(directory+'/fig5.png')
	os.remove(directory+'/fig5.svg')	
	os.remove(directory+'/fig5.pdf')
except OSError:
	pass
plt.savefig(directory+'/fig5.png', transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(directory+'/fig5.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.savefig(directory+'/fig5.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.show()

try:
	os.remove(dir_name+'/guinier-radius-results-formula.txt')
except OSError:
	pass	

data = open(dir_name+'/guinier-radius-results-formula.txt', 'a')
data.write('\n#(fit curve) R2=%.5g\tA=%.5g\tC=%.5g\n'%(popt[0],popt[1],popt[2]))
data.write('#ERRORS: R2=%.5g\tA=%.5g\tC=%.5g\n'%(pcov[0][0],pcov[1][1],pcov[2][2]))
data.write('\n#f(x)=R2+A/(C-x), where x is the electron density and y is Rg**2\n')
data.close()
