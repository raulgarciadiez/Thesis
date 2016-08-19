from operator import itemgetter 
import os,fnmatch
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from scipy.optimize import leastsq

limit=2.2 #limit for q*R
qmin=0.033 #minimum q value for fitting

N=2 #number of datasets used

def guinier_radius(suffix):	
	def find_minimum(filedata):
		for i in range(len(filedata[:,0])):
			if filedata[i,0]>qmin:
				n_min=i
				break
			elif qmin<filedata[0,0]:
				n_min=1
			else:
				pass	

		q=filedata[n_min:,0]
		I=filedata[n_min:,1]
		for i,val in enumerate(I):
			if ((val-I[i+5])<0) and (I[i+1]-I[i+6]<0) and(I[i+2]-I[i+7]<0) and ((val-I[i-5])>0) and (I[i+1]-I[i-4]>0) and(I[i+2]-I[i-3]>0):
				qpeak=q[i] #q_minimum, position 1st peak
				break
			else:
				pass
		return qpeak,n_min
		
	def find_maximum_fit(filedata,qpeak):
		R=4.5/qpeak
		Rg=3*R/5
		qmax=limit/Rg
		for i in range(len(filedata[:,0])):
			if filedata[i,0]>qmax:
				n_max=i
				break
			else:
				pass
		return n_max	
		
	def g(x,A,B):
		return A*np.power(x,2)+B

	for i in range(1,N+1):
		name=dir_name+'/curve_'+suffix+'-'+str(i)+'.dat'
		try:
			filedata=np.genfromtxt(name)
			index=i
		except IOError:
			pass
	
###### use them when calculating the q-range automatically
	def find_auto_range():	
		qpeak,N_min=find_minimum(filedata)
		N_max=find_maximum_fit(filedata,qpeak)	
		q_g=filedata[N_min:N_max,0]
		return q_g,N_min,N_max
########################################################
	
###### use them when the q-range is MANUALLY given
	def find_manual_range():
		q=filedata[:,0]
		name_limit=dir_name+'/guinier_range_manual.txt'
		filedata_limit=np.genfromtxt(name_limit)
		for (i,suf) in enumerate(filedata_limit[:,0]):
			if round(suf,3)==float(suffix):
				qmin=filedata_limit[i,1]
				qmax=filedata_limit[i,2]
			else:
				pass
		N_min=np.where(np.logical_and(q>=(round(qmin,3)-0.001), q<=(round(qmin,3)+.001)))[0][0]
		N_max=np.where(np.logical_and(q>=(round(qmax,3)-0.001), q<=(round(qmax,3)+.001)))[0][0]
		q_g=q[N_min:N_max]
		return q_g,N_min,N_max
########################################################	
	
	q_g,N_min,N_max=find_manual_range()	
	
	data.write('%.5g\t%.5g\t%.5g\n'%(float(suffix),filedata[N_min,0],filedata[N_max,0]))
	
	popt,pcov=opt.curve_fit(g, q_g, np.log(filedata[N_min:N_max,1]),p0=[50,np.log(max(filedata[N_min:N_max,1]))],maxfev=10000)
	
	Rg2=-3*popt[0]	
	lnI=popt[1]
	I0=np.exp(lnI)
	errRg2=3*pcov[0,0]
	errlnI=pcov[1,1]
	errI0=np.exp(errlnI)		
	return Rg2, errRg2,I0,errI0, index
		
	
suffixes=[]	
pattern1 = '*-1.dat'
pattern2 = '*-2.dat'
dir_name=os.path.dirname(os.path.realpath(__file__))
for root, dirs, files in os.walk(dir_name):
	for filename in fnmatch.filter(files, pattern1):
		ed=float(filename[6:-6])
		if ed!=336.88 and ed!=338.69:# ed!=335.13:
			suffixes.append(ed)
for root, dirs, files in os.walk(dir_name):
	for filename in fnmatch.filter(files, pattern2):
		ed=float(filename[6:-6])
		if ed!=336.88 and ed!=338.69:# ed!=335.13:
			suffixes.append(ed)

I0=np.empty(shape=(N,20))
errI0=np.empty(shape=(N,20))
Rg2=np.empty(shape=(N,20))
errRg2=np.empty(shape=(N,20))
ed=np.empty(shape=(N,20))
I0=np.empty(shape=(N,19))
errI0=np.empty(shape=(N,19))
Rg2=np.empty(shape=(N,19))
errRg2=np.empty(shape=(N,19))
ed=np.empty(shape=(N,19))
ind_count=np.empty(shape=(N))
try:
	os.remove(dir_name+'/guinier_range.txt')
except OSError:
	pass	
data = open(dir_name+'/guinier_range.txt', 'a')
data.write('#Electron density(e/nm3)\tqmin\tqmax\n ')	
data.close
for suffix in suffixes:
	print suffix
	data = open(dir_name+'/guinier_range.txt', 'a')
	a,b,c,d,ind=guinier_radius(str(suffix))
	data.close
	for (i,indc) in enumerate(ind_count):
		if (i+1)==ind:
			Rg2[i,int(ind_count[i])]=a
			errRg2[i,int(ind_count[i])]=b
			I0[i,int(ind_count[i])]=c
			errI0[i,int(ind_count[i])]=d
			ed[i,int(ind_count[i])]=suffix
			ind_count[i]+=1
		else:
			pass
data.close
def h(x,A,B,C):
	return A*np.power((x-B),2)+C
#def h2(x,A,B): #without constant term
#	return A*np.power((x-B),2)
def residuals_I0(pam,x,Y,errY):
	return (Y-h(x,pam[0],pam[1],pam[2]))/errY
#def residuals_I02(pam,x,Y,errY):
#	return (Y-h2(x,pam[0],pam[1]))/errY	

p0=[7.e22,346.,1.e23]	
#p02=[7.e22,346.]
#calculating for each individual experimental set
ed0_I0=[]
parameters_list=[]
for i in range(0,N):
	p,cov,infodict,mesg,ier = leastsq(residuals_I0,p0,args=(ed[i,:],I0[i,:],errI0[i,:]),ftol=1.e-12, maxfev=100000000,full_output=True, epsfcn=0.0001)
	ed0_I0.append(p[1])
	parameters_list.append(p)
	
for i in range(0,N):	
	plt.scatter(ed[i,:],I0[i,:],label=i+1)
	ed_plot=np.arange(min(ed[i,:]),max(ed[i,:]),0.1)
	plt.plot(ed_plot,h(ed_plot,*parameters_list[i]))
	plt.draw()	
plt.legend()
print parameters_list
plt.show()

#calculating for the 2 data set simultaneous
x=np.concatenate((ed[0,:],ed[1,:])) #electron density of 2 data set
p_total,cov_total,infodict_total,mesg_total,ier_total = leastsq(residuals_I0,p0,args=(x,np.concatenate((I0[0,:],I0[1,:])),np.concatenate((errI0[0,:],errI0[1,:]))),ftol=1.e-12, maxfev=100000000,full_output=True, epsfcn=0.0001)

plt.scatter(x,np.concatenate((I0[0,:],I0[1,:])))
ed_plot=np.arange(min(x),max(x),0.1)
plt.plot(ed_plot,h(ed_plot,*p_total))
print p_total
plt.show()

def f(x,R2,A,B,C):
	return R2+A/(C-x)-B/(C-x)**2
	
def residuals(pam,x,y,errY):
	return (y-f(x,pam[0],pam[1],pam[2],pam[3]))/errY

p0=[40**2,450000,0,p_total[1]]	
y=np.concatenate((Rg2[0,:],Rg2[1,:])) #gyration radius of 2 data set
erry=np.concatenate((errRg2[0,:],errRg2[1,:])) #gyration radius of 2 data set

#range the fitted curves by ed
ed_min=342.
ed_max=343.
ind_bad=np.where(np.logical_and(x<=ed_max,x>=ed_min))[0] #limiting the fitting range
xfit=np.delete(x,ind_bad)
yfit=np.delete(y,ind_bad)
erryfit=np.delete(erry,ind_bad)

ed_min2=345.
ed_max2=348.
ind_bad2=np.where(np.logical_and(xfit<=ed_max2,xfit>=ed_min2))[0] #limiting the fitting range
xfit=np.delete(xfit,ind_bad2)
yfit=np.delete(yfit,ind_bad2)
erryfit=np.delete(erryfit,ind_bad2)

popt,pcov=opt.curve_fit(f, xfit, yfit, p0,maxfev=100000)

p,cov,infodict,mesg,ier = leastsq(residuals,p0,args=(xfit,yfit,erryfit),ftol=1.e-12, maxfev=100000000,full_output=True, epsfcn=0.0001)
print zip(popt,p)

plt.errorbar(xfit,yfit,yerr=erryfit,label=r'Experimental with $R_gq_{max}=$%g'%(limit),fmt='o')
plt.plot(np.arange(min(x)-1,max(x)+1,0.05),f(np.arange(min(x)-1,max(x)+1,0.05),*popt),label=r'Fitting with $R_{0}=$%g and $\rho_m=$%g'%((popt[0])**0.5,popt[-1]))
plt.plot(np.arange(min(x)-1,max(x)+1,0.05),f(np.arange(min(x)-1,max(x)+1,0.05),*p),label=r'Fitting with $R_{0}=$%g and $\rho_m=$%g: Leastsq'%((p[0])**0.5,p[-1]))
plt.legend(loc=0)
plt.grid(True)
plt.title(r'R$_g$ vs electron density')
plt.xlabel(r'Electron Density/nm$^{-3}$')
plt.ylabel('Guinier Radius/nm')
plt.ylim([-100,3500])
plt.show()


result=np.empty([len(x),5])
result[:,0]=x
result[:,1]=y
result[:,2]=erry
result[:,3]=np.concatenate((I0[0,:],I0[1,:]))
result[:,4]=np.concatenate((errI0[0,:],errI0[1,:]))

try:
	os.remove(dir_name+'/guinier-radius-results.txt')
except OSError:
	pass	
	
np.savetxt(dir_name+'/guinier-radius-results.txt',result)

prnt
data = open(dir_name+'/guinier-radius-results.txt', 'a')
data.write('#Electron density(e/nm3)\tRg\tError\tI0\tError\n ')
for i in range(len(suffixes)):
	data.write('%.5g\t%.5g\t%.5g\t%.5g\t%.5g\n'%(suffixes[i],Rg[i],errRg[i],qmaxRg[i],qpeak[i]))
data.write('\n#(fit curve) R2=%.5g\tA=%.5g\tB=%.5g\tC=%.5g\n'%(popt[0],popt[1],popt[2],popt[3]))
data.write('#ERRORS: R2=%.5g\tA=%.5g\tB=%.5g\tC=%.5g\n'%(pcov[0][0],pcov[1][1],pcov[2][2],pcov[3][3]))
data.write('\n#(least sq) R2=%.5g\tA=%.5g\tB=%.5g\tC=%.5g\n'%(p[0],p[1],p[2],p[3]))
data.write('\n#f(x)=R2+A/(C-x)-B/(C-x)**2, where x is the electron density and y is Rg**2\n')
data.close()
