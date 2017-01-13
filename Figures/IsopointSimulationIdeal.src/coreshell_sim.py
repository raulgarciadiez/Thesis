import numpy as np
import sys 
import matplotlib.pyplot as plt
#from math_models import *
sys.path.append('/home/rgarciad/Dokumente/Programs SAXS/AutoSAXS-python/SAXSTools/src')
import saxstools as ST

R=50.
pd=0.05

nu=0.6666
rhocore=300.
rhoshell=400.

rhoav=rhoshell*(1-nu**3) + rhocore*nu**3        
print 'average density=',rhoav

parameters=[R,pd*R/2.355,nu,rhocore,rhoshell]

q=np.logspace(-2,0,1000)

d=ST.Gaussian_Distribution(1, 2) #R,sigma
f=ST.FF_Core_Shell_Solvent(3,0,4,5) #nu, rho_solv, rho_core, rho_shell
s=ST.SAXScurve(f, d)	

for rho_solvent in np.linspace(280,420,11.):
	Rho_solvent=(rho_solvent, )
        I=np.array(s.compute(q,Rho_solvent+tuple(parameters)))	
        
        print rho_solvent - rhoav	
        
        result=np.empty(shape=(len(I),2))
        result[:,0]=q
        result[:,1]=I        
        np.savetxt('coreshell_solv_%.1f.dat'%(rho_solvent - rhoav),result)
        


