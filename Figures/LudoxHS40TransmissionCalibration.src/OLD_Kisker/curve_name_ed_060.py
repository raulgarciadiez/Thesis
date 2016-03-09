import os
import numpy as np
import scipy.optimize as opt
import matplotlib.pyplot as plt

dir_name=os.path.dirname(os.path.realpath(__file__))

def ed_interpol(suffix):	
	ed1,ed2,ed=find_ed(float(suffix),'059','061')
	return ed1,ed2,ed
	
def find_ed(suffix,trans1,trans2):	
	name1=dir_name+'/trans_'+trans1+'_density.dat'
	filedata1=np.genfromtxt(name1)	
	name2=dir_name+'/trans_'+trans2+'_density.dat'
	filedata2=np.genfromtxt(name2)		
	for (i,sampley) in enumerate(filedata1[:,0]):
		if round(sampley,1)==round(suffix,1):
			time_index=i
			ed1=filedata1[i,1]
		else:
			pass
	for (i,sampley) in enumerate(filedata2[:,0]):
		if round(sampley,1)==round(suffix,1):
			ed2=filedata2[i,1]
		else:
			pass	
	ed=ed1+((ed2-ed1)*(time_index-12.)/(len(suffixes)-1.)) #interpolation (the first 12 points useless)
	return ed1,ed2,ed
	
suffixes=np.arange(-5.5,4.01,0.5) 

ed1_list=[]
ed2_list=[]
ed_list=[]
for suffix in suffixes:
		suffix=str(suffix)
		ed1,ed2,ed=ed_interpol(suffix)
		ed1_list.append(ed1*1000.)
		ed2_list.append(ed2*1000.)
		ed_list.append(ed*1000.)
plt.plot(suffixes+5.5,ed1_list, label=u'$t_1$',color='k',linestyle='-.',linewidth=1.5)		
plt.plot(suffixes+5.5,ed2_list, label=u'$t_1+15$ min',color='k', linestyle='--',linewidth=1.5)
plt.plot(suffixes+5.5,ed_list, label='Calibrated value',linewidth=2.5,color='k')	
plt.xlabel('Vertical position / mm',fontsize=17)
plt.ylabel('Solvent density / g cm$^{-3}$',fontsize=17,labelpad=-25)
plt.xlim([0,9.5])
plt.ylim([995.,1090.])
plt.tick_params(axis='both',which='major',labelsize=13.5)
plt.yticks([997,1020,1040,1060,1080,1088],[r'$\rho_2$ (min)',1.02,1.04,1.06,1.08,r'$\rho_1$ (max)'])
plt.grid(True)

plt.legend()
name_fig='/home/rgarciad/Dokumente/Projects/Contrast matching/ARTICLES/Article-1/figures/fig1.png'
try:
	os.remove(name_fig)
	os.remove(name_fig[:-4]+'.svg')
	os.remove(name_fig[:-4]+'.pdf')	
except OSError:
	pass
plt.savefig(name_fig, transparent=True, bbox_inches='tight', pad_inches=0.1,dpi=500)
plt.savefig(name_fig[:-4]+'.svg', transparent=True, bbox_inches='tight', pad_inches=0.1)	
plt.savefig(name_fig[:-4]+'.pdf', transparent=True, bbox_inches='tight', pad_inches=0.1)
plt.show()	
