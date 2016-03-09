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

dir_name=os.path.dirname(os.path.realpath(__file__))

def func(rho_solvent, pam, x):
	return np.array(s.compute(x, (rho_solvent, )+tuple(pam)))
	
R=72.5
#R0=68.
R0=60.
nu=R0/R
#nu_alt=R0_alt/R

print nu

#nu0=44.2/49.7
#R0=nu0*R

rhocore=340.#340.
rhoshell=360.#360.

d=ST.Gaussian_Distribution(1, 2) #R,sigma
f=ST.FF_Core_Shell_Solvent(3,0,4,5) #nu,rho_solvent,rho_core,rho_shell
s=ST.SAXScurve(f, d)

qmin_list=[0.09,0.155]#,0.22,0.28,0.34]
qmin_list=np.array(qmin_list)/(R/50.5) #double size of R

q=np.linspace(0.05, 0.064,1000)

#q=np.linspace(0.008,max(qmin_list)+0.05,400)
#rho_solvent_list=np.arange(333.,361.,1.)
rho_solvent_list=np.genfromtxt('suffixes.dat')
	
#select q-range for parabola fitting	
def compact_q(q,dI,qmin):
	nmin=np.where(np.logical_and(q>=(round(qmin,5)-0.00003), q<=(round(qmin,5)+0.00003)))[0][0]	
	index_max0=nmin+np.where(dI[nmin:]==max(dI[nmin:nmin+50]))[0][0] #looks for the maximum for extra # points
	for i in range(len(q[nmin:])):
		if dI[nmin-i]>dI[index_max0]:	
			index_min=nmin-i
			break
		else:
			pass	
	index_max=index_max0+int((index_max0-nmin)*0.15) #reduce in #% the imax
	index_min=index_min+int((index_max0-nmin)*0.15)
	q_fit=q[index_min:index_max]
	dI_fit=dI[index_min:index_max]
	return q_fit,dI_fit	
	
def curves_isoscattering_point():
	def plot_dI(sigma):
		p0=[R,sigma,nu,rhocore,rhoshell]
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

	dI_list=[]	
	for sigma in sigma_range:
		mean=plot_dI(sigma)
		matrix=np.empty(shape=(len(q),2))
		matrix[:,0]=q
		matrix[:,1]=mean
		np.savetxt(dir_name+'/polydispersity_curves/%s_%.1f_def.dat'%(str(R),sigma*2.355*100/R),matrix)
		dI_list.append(mean)
	plt.legend()
	plt.show()	
	return dI_list


def fit_lorentz(q_fit,I_fit):
	def function(x,sigma,x0,amp,C):
		def lorentz(x,sigma,x0):
			return sigma/(sigma**2+np.power(x-x0,2))
		return amp*lorentz(x,sigma,x0)+C   
	p0=[0.01,q0,-0.1,1.]
	popt,pcov=opt.curve_fit(function, q_fit, I_fit,p0,maxfev=10000)	
	qmin_pos=q_fit[np.where(function(q_fit,*popt)==min(function(q_fit,*popt)))[0][0]]	
	q_plot=np.concatenate((np.linspace(min(q_fit)-0.05,min(q_fit),100),q_fit,np.linspace(max(q_fit),max(q_fit)+0.05,100)))

	plt.plot(q,I,label='exp')
	plt.plot(q_plot,function(q_plot,*popt),label='lorentz',color='r',linewidth=3)	
	plt.legend()
	plt.show()
	return popt	

pd_range=np.arange(0.,30.,.3)
sigma_range=pd_range*R/(2.355*100.)

dI_list=curves_isoscattering_point()
np.savetxt('isoscattering_curves_polydispersity_%s.txt'%(str(R)),dI_list)
#dI_list=np.genfromtxt('isoscattering_curves_polydispersity_%s.txt'%(str(R)))
print 'isoscattering_curves_polydispersity_%s.txt'%str(R)

#qmin_matrix=np.empty(shape=(len(sigma_range),len(qmin_list)))
#pd_matrix=np.empty(shape=(len(sigma_range),len(qmin_list)))
#C_matrix=np.empty(shape=(len(sigma_range),len(qmin_list)))
q0_list=[]
pd_list=[]
for i in range(len(sigma_range)):
	print i
	filedata=np.genfromtxt(dir_name+'/polydispersity_curves/%s_%.1f_def.dat'%(str(R),sigma_range[i]*2.355*100/R))
	print '/polydispersity_curves/%s_%.1f.dat'%(str(R),sigma_range[i]*2.355*100/R)
	qsim=filedata[:,0]
	I=filedata[:,1]
	qmin=qsim[I.argmin()]
	try:
		q0_list.append(qmin/q0)
	except NameError:
		q0=qmin
		q0_list.append(qmin/q0)
	pd_list.append(sigma_range[i]*2.355*100/R)
	
#	for (j,qmin) in enumerate(qmin_list):
#		q_fit,I_fit=compact_q(q,I,qmin)
#		I_fit=np.array(I_fit)
#		q0=q_fit[np.where(I_fit==min(I_fit))]
#		qmin_matrix[i][j]=q0
#		p=fit_lorentz(q_fit,I_fit)
#		pd_matrix[i][j]=100*2.*p[0]/p[1]
#		C_matrix[i][j]=min(I_fit)
#for i in range(len(sigma_range)):
#	print pd_matrix[i], sigma_range[i]*2.355*100/R
	#print C_matrix[i], sigma_range[i]*2.355*100/R
plt.scatter(pd_list, q0_list)	
#plt.plot(sigma_range*2.355*100/R,C_matrix[:,0],label='First minimum')	
#plt.plot(sigma_range*2.355*100/R,C_matrix[:,1],label='Second minimum')	
plt.xlabel('Polydispserity')
plt.ylabel('Deviation')
plt.legend(loc=0)
plt.show()

#colors = cm.winter(np.linspace(0, 1, len(qmin_matrix[0])))		
#for (k,c) in zip(range(len(qmin_matrix[0])),colors):
#	plt.plot(sigma_range*2.355*100/R,map(lambda x: 100*(x-qmin_matrix[0,k])/qmin_matrix[0,0], qmin_matrix[:,k]), color=c, label='Minimum %i'%k) #polydispersity vs q*R0 in %
#	plt.ylabel(r'Difference in $\%$')
#	plt.xlabel(r'Polydispersity degree in $\%$')
#	plt.draw()
#plt.legend()
#plt.grid(True)
#plt.show()


















def write_results_multi_layer():
	folder='/Calculated Isoscattering Points/'
	numfiles = len([f for f in os.listdir(dir_name+folder) if os.path.isfile(os.path.join(dir_name+folder, f)) and f[0] != '.'])
	data = open(dir_name+folder+'Minima_result_%i.txt'%int(numfiles+1), 'a')
	data.write('#Multi-shell model: Isoscattering point study with mean and standard deviation\n')
	data.write('#Parameters: R=%.1f, Number of layers=%i, ed_core=%.0f, ed_shell=%.0f, ed_shell2=%.0f, ed_shell3=%.0f, N(shell)=%i, N(shell1)=%i, N(shell2)=%i\n\n'%(R,int(N_layers),ed_core, ed_shell, ed_shell2, ed_shell3, int(N_shell), int(N2), int(N3)))
	data.write('#Polydispersity\t1st min\t2nd min\t3rd min\t4th min\n ')
	for (k,sigma) in zip(range(len(qmin_matrix[:,0])),sigma_range):
		data.write('%.5g\t%.5g\t%.5g\t%.5g\t%.5g\n'%(sigma*2.355/R,qmin_matrix[k,0],qmin_matrix[k,1],qmin_matrix[k,2],qmin_matrix[k,3]))
	data.close()

def fit_results_solution():
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
	solution=equation_solutions()
	def straight_line(x,A,B):
		return A*x+B
	for (k,sigma) in zip(range(len(qmin_matrix[:,0])),sigma_range):
		popt,pcov=opt.curve_fit(straight_line, np.array(qmin_matrix[k]), np.array(solution[:len(qmin_matrix[k])]), [R,0.01],maxfev=10000)
		print 'R=',popt[0],' error=',pcov[0][0], ' sigma=',sigma
	
