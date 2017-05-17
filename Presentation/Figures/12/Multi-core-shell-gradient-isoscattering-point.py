import numpy as np
import matplotlib.pyplot as plt
import sys,os
sys.path.append('/home/rgarciad/Dokumente/Programs SAXS/AutoSAXS-python/SAXSTools/src')
import saxstools as ST
from operator import itemgetter 
import os,fnmatch
import scipy.optimize as opt
from scipy import special
import matplotlib.cm as cm

def func(rho_solvent, pam, x):
	return np.array(s.compute(x, (rho_solvent, )+tuple(pam)))
	
def R_list(N):
	def R_i(i,N):
		return ((float(i)/float(N))**(1./3.))
	
	R_list=[]
	for i in range(1,N,1):
		R_list.append(R_i(i,N))
	return R_list	
	

#SELECTING NUMBER OF LAYERS
#N_layers=15 #No shells
#N_shell=5 #No shells with high density

#### ---- NORMAL CORE-SHELL ---######
R=49.7
R0=44.2
nu=R0/R
sigma=4.5
rhocore=339.7
rhoshell=361.8

p0=[R,sigma,nu,rhocore,rhoshell]

qmin_list=[0.09,0.16,0.22,0.28,0.34]
qmin_list=np.array(qmin_list)/(R/50.5) #double size of R

#ed_core=341.7
#ed_shell=361.
#ed_shell2=370.
#ed_shell3=340
#N2=0 #number of shell No.2
#N3=0 #number of shell No.3

d=ST.Gaussian_Distribution(1, 2) #R,sigma
f=ST.FF_Core_Shell_Solvent(3,0,4,5) #nu,rho_solvent,rho_core,rho_shell
s=ST.SAXScurve(f, d)

#R_fraction=R_list(N_layers)
#initial parameters:  R, sigma, rho_shell (x N_layers times), C0, C4, N0 (x13 time)
#ed_list=[ed_core]*(len(R_fraction)+1-N2-N3-N_shell)+[ed_shell]*(N_shell)+N2*[ed_shell2]+N3*[ed_shell3]

#definition of the function to be used
#d=ST.Gaussian_Distribution(1, 2) #R,sigma
#f=ST.FF_Onion(0,R_fraction,range(3,len(R_fraction)+1+3)) #rho_solvent,Radii, electron densities (x N0 times)

#s=ST.SAXScurve(f, d)

#q=np.linspace(0.008,0.29,2000)
q=np.linspace(0.008,max(qmin_list)+0.05,2000)
rho_solvent_list=np.arange(330.,365.,.5)

#select q-range for parabola fitting	
def compact_q(q,dI,qmin):
	nmin=np.where(np.logical_and(q>=(round(qmin,4)-0.0001), q<=(round(qmin,4)+.0001)))[0][0]	
	index_max=nmin+np.where(dI[nmin:]==max(dI[nmin:nmin+20]))[0][0] #looks for the maximum for extra # points (normally 20 points)

	for i in range(len(q[nmin:])):
		if (dI[nmin-i]>dI[index_max]):# or (dI[nmin-i]<dI[nmin-(i+3)]):
			index_min=nmin-i
			break
		else:
			pass	
	try:
		index_min
		print q[index_min]
	except NameError:
		index_min=nmin-int(index_max-nmin)
	print index_min, index_max		
	q_fit=q[index_min:index_max]
	dI_fit=dI[index_min:index_max]
	return q_fit,dI_fit
	
def equation_solutions():
	def f(x):
		return np.tan(x)-x	
	def f_prime(x):
		return 1/(np.power(np.cos(x),2))-1	
	def newt(x,n):
		for i in range(n):
			if f_prime(x)==0:
				return x
			x=x-f(x)/f_prime(x)	    
		return x	
	q=np.arange(0.5,50,0.1)	
	solutions=[]
	for q0 in q:
		x0=newt(q0,50)
		if x0<25. and x0>4.:
			solutions.append(x0)
	solution=sorted(list(set(solutions))) #list with solutions to equation tanx-x=0
	return solution	
	
def voigt(x,amp,fwhm, pos,shape,B):
     tmp = 1/special.wofz(np.zeros((len(x))) \
           +1j*np.sqrt(np.log(2.0))*shape).real
     tmp = tmp*amp* \
           special.wofz(2*np.sqrt(np.log(2.0))*(x-pos)/fwhm+1j* \
           np.sqrt(np.log(2.0))*shape).real
     return tmp+B
     	
def curves_isoscattering_point():
	def plot_dI(sigma):
		#p0=[R,sigma]+ed_list
		def mean(listfile,ratio):
			listfile=sorted(listfile)
			length=int(ratio*len(listfile))
			if length!=0:
				listfile=listfile[length:-length]
			else:
				pass
			avg=sum(listfile)/len(listfile)
			sigma=np.power(sum(map(lambda x: np.power(x-avg,2),listfile))/len(listfile),0.5)
			return sigma/avg

		matrix_q=np.empty(shape=(len(rho_solvent_list),len(q)))
		for (j,rhos) in enumerate(rho_solvent_list):
			I0=func(rhos, p0, q)
			matrix_q[j]=I0
	
		mean_list=[]
		for (k,q0) in enumerate(q):	
			mean_list.append(mean(matrix_q[:,k],0.05))	
		plt.plot(q,mean_list,label=sigma*2.355*100/p0[0])
		plt.draw()
		return mean_list

	mean=plot_dI(sigma)
	plt.legend()
	plt.show()	
	return mean

#dI_list=curves_isoscattering_point()
#result=np.empty(shape=(len(dI_list),2))
#result[:,0]=q
#result[:,1]=dI_list
#np.savetxt('isoscattering_curves_polydispersity_%s.txt'%(str(R)),result)
dI_list=np.genfromtxt('isoscattering_curves_polydispersity_%s.txt'%(str(R)))
print 'isoscattering_curves_polydispersity_%s.txt'%str(R)

qmin_matrix=[]
for (j,qmin) in enumerate(qmin_list):
	q_fit,dI_fit=compact_q(q,dI_list,qmin)
	dI_fit=np.array(dI_fit)
	q0=q_fit[np.where(dI_fit==min(dI_fit))]
	qmin_matrix.append(q0)
print qmin_matrix

prnt	

colors = cm.winter(np.linspace(0, 1, len(qmin_matrix[0])))		
for (k,c) in zip(range(len(qmin_matrix[0])),colors):
	#plt.scatter(qmin_matrix[0],map(lambda x,y: (y-x)/y, qmin_matrix[k], qmin_matrix[0]), color=c, label='%.1f'%(sigma_range[k]*2.355*100/R)) 
	plt.plot(sigma_range*2.355*100/R,map(lambda x: (x-qmin_matrix[0,k])/qmin_matrix[0,0], qmin_matrix[:,k]), color=c, label=k) #polydispersity vs q*R0 in %
	plt.draw()
plt.legend()
plt.grid(True)
plt.show()

dir_name=os.path.dirname(os.path.realpath(__file__))
folder='/Calculated Isoscattering Points/'
numfiles = len([f for f in os.listdir(dir_name+folder) if os.path.isfile(os.path.join(dir_name+folder, f)) and f[0] != '.'])
data = open(dir_name+folder+'Minima_result_%i.txt'%int(numfiles+1), 'a')
data.write('#Multi-shell model: Isoscattering point study with mean and standard deviation\n')
data.write('#Parameters: R=%.1f, Number of layers=%i, ed_core=%.0f, ed_shell=%.0f, ed_shell2=%.0f, ed_shell3=%.0f, N(shell)=%i, N(shell1)=%i, N(shell2)=%i\n\n'%(R,int(N_layers),ed_core, ed_shell, ed_shell2, ed_shell3, int(N_shell), int(N2), int(N3)))
data.write('#Polydispersity\t1st min\t2nd min\t3rd min\t4th min\n ')
for (k,sigma) in zip(range(len(qmin_matrix[:,0])),sigma_range):
	data.write('%.5g\t%.5g\t%.5g\t%.5g\t%.5g\n'%(sigma*2.355/R,qmin_matrix[k,0],qmin_matrix[k,1],qmin_matrix[k,2],qmin_matrix[k,3]))
data.close()

solution=equation_solutions()
def straight_line(x,A,B):
	return A*x+B
for (k,sigma) in zip(range(len(qmin_matrix[:,0])),sigma_range):
	popt,pcov=opt.curve_fit(straight_line, np.array(qmin_matrix[k]), np.array(solution[:len(qmin_matrix[k])]), [R,0.01],maxfev=10000)
	print 'R=',popt[0],' error=',pcov[0][0], ' sigma=',sigma
	
	
print qmin_matrix		
	
