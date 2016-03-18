import numpy as np
import time, os,re, sys,fnmatch, shutil
import matplotlib.pyplot as plt

dir_name=os.path.dirname(os.path.realpath(__file__))


suffixes=[]
for root, dirs, files in os.walk(dir_name):
	for (k,filename) in enumerate(fnmatch.filter(files, 'curves_*')):
		X=float(filename[7:-8])
		suffixes.append(X)
suffixes.sort() 

Iq=[]
for (i,osm) in enumerate(suffixes):
	for hdf in [662,667,669]:
		try:
			filedata=np.genfromtxt('curves_%.4f_%i.dat'%(osm,hdf))
		except IOError:
			pass	
	q=filedata[:,0]
	I=filedata[:,1]
	index=np.where(np.array(map(lambda x: round(x,3), q))==0.123)[0][0]
	Iq.append(I[index])
	
result=np.empty(shape=(len(suffixes),2))	
result[:,0]=suffixes
result[:,1]=Iq

np.savetxt('isopoint_intensity_SAXS',result)
