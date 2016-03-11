from operator import itemgetter 
import os,fnmatch
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt
from scipy import special
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter

dir_name=os.path.dirname(os.path.realpath(__file__))
def equation_solutions(): #calcution of roots for tanx-x with newton	
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

def q_range(qmin,qmax):
	q=q_list
	nmin=np.where(np.logical_and(q>=(round(qmin,4)-0.0002), q<=(round(qmin,4)+.0002)))[0][0]
	nmax=np.where(np.logical_and(q>=(round(qmax,4)-0.0002), q<=(round(qmax,4)+.0002)))[0][0]
	q_lorentz=q[nmin:nmax]
	return q_lorentz

def lorentz(x,sigma,x0,amp,C):
	def lorentz(x,sigma,x0):
		return sigma/(sigma**2+np.power(x-x0,2))
	return amp*lorentz(x,sigma,x0)+C       		

filedata=np.genfromtxt('standard_deviation-2-datasets.txt') #input data from file
q_list=filedata[:,0]
mean_list=filedata[:,1]

parameters=np.genfromtxt('lorentzian-pam-2-datasets.txt')

fig = plt.figure()
ax = fig.add_subplot(111)
		
majorLocator=MultipleLocator(0.1)
minorLocator=MultipleLocator(0.05)
ax.yaxis.set_major_locator(majorLocator)
ax.yaxis.set_minor_locator(minorLocator)

ax.scatter(q_list,mean_list,linewidth=2,color='b')
ax.plot(q_range(0.085,0.102),lorentz(q_range(0.085,0.102),*parameters[0]),linewidth=3,color='r')
ax.plot(q_range(0.146,0.163),lorentz(q_range(0.146,0.163),*parameters[1]),linewidth=3,color='r')
ax.plot(q_range(0.201,0.25),lorentz(q_range(0.201,0.25),*parameters[2]),linewidth=3,color='r')
ax.plot(q_range(0.262,0.31),lorentz(q_range(0.262,0.31),*parameters[3]),linewidth=3,color='r')
ax.plot(q_range(0.324,0.371),lorentz(q_range(0.324,0.371),*parameters[4]),linewidth=3,color='r')

Ipos=map(lambda x: mean_list[np.where(np.logical_and(q_list>=(round(x,4)-0.0003), q_list<=(round(x,4)+.0003)))[0][0]], parameters[:,1])
labels=[u'$q_1^{\star}$',u'$q_2^{\star}$',u'$q_3^{\star}$',u'$q_4^{\star}$',u'$q_5^{\star}$',]
for i,txt in enumerate(labels):
	ax.annotate(txt, (parameters[:,1][i],Ipos[i]-0.05),fontsize=15)
	ax.vlines(parameters[:,1][i],Ipos[i],Ipos[i]-0.035)

ax.set_xlabel(u'$q$ / nm$^{-1}$',fontsize=17)
ax.set_ylabel('Relative Standard Deviation',fontsize=17)
ax.set_xlim([0.08,0.4])
ax.set_ylim([0,0.6])
ax.grid(True)
ax.set_xscale('log')

def positions(x, pos):
	return '%.1f' % (x)

ax.yaxis.set_major_formatter(FuncFormatter(positions))
ax.set_xticks([0.08,0.1,0.2,0.4])
ax.set_xticklabels(['0.08','0.1','0.2','0.4'])
ax.tick_params(axis='both',which='major',labelsize=13.5)

directory='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures'
try:
	os.remove(directory+'/fig4.png')
	os.remove(directory+'/fig4.svg')	
	os.remove(directory+'/fig4.pdf')
except OSError:
	pass
plt.savefig(directory+'/fig4.png', transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(directory+'/fig4.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.savefig(directory+'/fig4.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.show()

solution=equation_solutions()

result=np.empty(shape=(5,5))
result[:,0]=parameters[:,1]
result[:,1]=parameters[:,0]
R=map(lambda x,y: round(x/y,2), solution[:-2], parameters[:,1])
result[:,2]=R
pd=map(lambda x,y: round(x*100.*2/y,2),result[:,1],result[:,0])
result[:,4]=pd
result[:,3]=map(lambda x,y:round(x*y/200.,2),result[:,4],result[:,2])
np.savetxt('isoscattering_results.txt',result)
