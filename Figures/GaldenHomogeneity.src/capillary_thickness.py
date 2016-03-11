import numpy as np

filedata=np.genfromtxt('Hilgenberg-1mm-sep.dat')


index_list=range(49,67)

xvalues=np.empty(shape=(101,1))
Tglass=np.empty(shape=(len(index_list),101))


for (I,n) in enumerate(index_list):
	for (i,x) in enumerate(filedata[n*101:(n+1)*101,0]):
		Tglass[I][i]=filedata[i+n*101,2]
		xvalues[i][0]=x
Tvalues=[]	
for (J,x) in enumerate(xvalues[:,0]):
	Tvalues.append(np.mean(Tglass[:,J]))


for (i,x) in enumerate(filedata[:,0]):
	ind=np.where(xvalues[:,0]==x)[0][0]
	filedata[i,2]= filedata[i,2]/Tvalues[ind]
	
np.savetxt('Hilgenberg-1mm-sep_Glass_norm.dat',filedata)	
	
	
