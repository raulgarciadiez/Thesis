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
	

data=open('Hilgenberg-1mm-sep_Glass_norm.dat','a')
data.write('#Sample-x\tSample-y\tNormalized transmission to glas\n')	
for (i, line) in enumerate(filedata):
	if round(line[0],1)==104.2:
		data.write('%.8g	%.8g	%.8g\n\n' %(line[0],line[1],line[2]))
	else:
		data.write('%.8g	%.8g	%.8g\n' %(line[0],line[1],line[2]))
data.close()
