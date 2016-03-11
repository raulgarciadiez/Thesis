import os
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt

dir_name=os.path.dirname(os.path.realpath(__file__))

def change_name(suffix):	
	name=dir_name+'/hdf_fcm_201403_060_Sam_'+suffix+'.dat'
	filedata=np.genfromtxt(name)
	
	ed=find_ed(float(suffix),'059','061')
	filename=dir_name+'/curves_ed/curve_'+str(round(ed,2))+'.dat'
	np.savetxt(filename,filedata)

	
def find_ed(suffix,trans1,trans2):	
	name1=dir_name+'/trans_'+trans1+'_ed.dat'
	filedata1=np.genfromtxt(name1)	
	name2=dir_name+'/trans_'+trans2+'_ed.dat'
	filedata2=np.genfromtxt(name2)		
	for (i,sampley) in enumerate(filedata1[:,0]):
		if round(sampley,1)==round(suffix,1):
			ed1=filedata1[i,1]
		else:
			pass
	for (i,sampley) in enumerate(filedata2[:,0]):
		if round(sampley,1)==round(suffix,1):
			ed2=filedata2[i,1]
		else:
			pass	
	ed=(ed1+ed2)/2	
	sigma=np.power(sum(map(lambda x: np.power(x-ed,2),[ed1,ed2]))/len([ed1,ed2]),0.5)		
	print '%.1f'%ed, '%.1f'%sigma#, ed1-ed2	
	return ed
	
suffixes=np.arange(-5.5,4.01,0.5) 

for suffix in suffixes:
		suffix=str(suffix)
		change_name(suffix)
