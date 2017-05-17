
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import gridspec
from matplotlib import rc

from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter
import matplotlib.colors as colors
import matplotlib.cm as cmx
from matplotlib.ticker import MultipleLocator, FormatStrFormatter,FuncFormatter

import matplotlib.collections as mcoll
import matplotlib.path as mpath

from matplotlib.widgets import Slider

############################################

def colorline(axis, x, y, z=None, cmap=plt.get_cmap('copper'), norm=plt.Normalize(0.0, 1.0), linewidth=3, alpha=1.0):
    """
    http://nbviewer.ipython.org/github/dpsanders/matplotlib-examples/blob/master/colorline.ipynb
    http://matplotlib.org/examples/pylab_examples/multicolored_line.html
    Plot a colored line with coordinates x and y
    Optionally specify colors in the array z
    Optionally specify a colormap, a norm function and a line width
    """
        
    def make_segments(x, y):
            """
            Create list of line segments from x and y coordinates, in the correct format
            for LineCollection: an array of the form numlines x (points per line) x 2 (x
            and y) array
            """

            points = np.array([x, y]).T.reshape(-1, 1, 2)
            segments = np.concatenate([points[:-1], points[1:]], axis=1)
            return segments        

    # Default colors equally spaced on [0,1]:
    if z is None:
        z = np.linspace(0.0, 1.0, len(x))

    # Special case if a single number:
    if not hasattr(z, "__iter__"):  # to check for numerical input -- this is a hack
        z = np.array([z])

    z = np.asarray(z)

    segments = make_segments(x, y)
    lc = mcoll.LineCollection(segments, array=z, cmap=cmap, norm=norm,
                              linewidth=linewidth, alpha=alpha)

    axis.add_collection(lc)

    return lc
    
#######################################################    

def plot_biplot(x, information, rhomin, rhomax):
    ## Formatting input
    if callable(information):
        n = 100
        width = 20
 #       x = np.linspace(0, 1, n)
        y = information(x)
    else:
        n = len(information)
        width = int(n/5)
#        x = np.arange(n)
        y = information
        
    array = np.repeat(y, width).reshape((len(y), width))

    # Font type for all plots
    rc('font',**{'family':'serif','serif':['Palation'], 'size':24, 'weight':'bold'})
    rc('text', usetex=True)
    mpl.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]

    # Creating plot
#    fig = plt.figure(figsize=(18,10))
    
    fig1, ax1 = plt.subplots(figsize=(2, 10))
#    gs = gridspec.GridSpec(8, 4)
#    ax1 = fig.add_subplot(gs[1:, 0])

    
#    ax1 = fig.add_axes([0.05, 0.05, 0.05, 0.8])      
#    ax2 = fig.add_axes([0.2, 0.05, 0.75, 0.8])
    #ax1 = fig.add_subplot(111)
    #ax2 = fig.add_subplot(111)
    
    colormap_chosen = mpl.colors.LinearSegmentedColormap.from_list('mycolors',['red','yellow']) #['yellow','yellow','#F7F8E0','yellow','red','#8A0808']
    colormap_chosen = 'OrRd_r'#'gist_heat' #hot
    cm = plt.get_cmap(colormap_chosen)
    cNorm  = colors.Normalize(vmin=rhomin, vmax=rhomax)
  
    ax1.imshow(array, cmap=cm, norm=cNorm)
 #   ax2 = fig.add_subplot(gs[1:, 1:5])
 
    fig1 = plt.gcf()
 
    fig2, ax2 = plt.subplots(figsize=(10, 8))
    
    x_0, rho_0 = evolver.rho_aprox(0.5)
    ax2.plot(rho_0, x_0, linewidth=5, linestyle="-", c="grey", zorder=1, alpha=0.3)  
    ax2.plot(information, x, linewidth=8, linestyle="-", c="black", zorder=1)                   
    ax2.plot(information, x, linewidth=5, linestyle="-", c="white", zorder=1)                   

##### TRYING TO MAKE LINES WITH COLOR GRADIENTS    
#    ax2.scatter(information,x,c=range(len(information)), marker='_', s=30)
#    path = mpath.Path(np.column_stack([y, x]))
#    verts = path.interpolated(steps=3).vertices
#    xcolor, ycolor = verts[:, 0], verts[:, 1]
    colorline(ax2, y, x, z=rhomin*(rhomin-y)/(rhomin-rhomax) + rhomax*(rhomax-y)/(rhomax-rhomin), cmap=cm, norm=cNorm, linewidth=5, alpha=1)

#    gs.update(wspace=0.5, hspace=0.5)

    # Stetic tuning of plot
    ax2.set_ylim([min(x),max(x)])
    ax2.set_xlim([990,1093])
    ax2.set_xlabel(r"\textbf{Density / g L}$\boldsymbol{^{-1}}$")
    ax2.set_ylabel(r"\textbf{Height / mm}",rotation=270, labelpad= 10)#fontsize=20,
        
    ax2.yaxis.set_label_position("right")
    ax2.tick_params(labeltop=True)
    ax2.grid(True)    
    plt.setp(ax2.get_xticklabels(), fontsize=18)

    # Final Configuration
    plt.setp(ax1.get_xticklabels(), visible=False)
    plt.setp(ax1.get_yticklabels(), visible=False)
    plt.setp(ax2.get_yticklabels(), visible=False)
    ax1.get_xaxis().set_visible(False)
    for axis in ['top','bottom','left','right']:
         ax1.spines[axis].set_linewidth(5)


#    fig = plt.gcf()


    fig2 = plt.gcf()

    fig3, axslider = plt.subplots(figsize=(10, 1))
    #axslider  = plt.axes([0.3, 0.94, 0.5, 0.04], axisbg=None)
    #    axslider = fig.add_subplot(gs[0,1:3])
    samp = Slider(axslider, 'Time (min)', 0., maxtime, valinit=0,color='grey',alpha=0.3,valfmt='%i'.ljust(5))
    samp.set_val(float(time)/60.)
    
    fig3 = plt.gcf()

    return fig1, fig2, fig3


class DensityGradientEvolver(object):
    def __init__(self, N=2000, x_size=2000):
        # Input variables of the equation
        self.rho1 = 1000*0.996657*np.exp(0.0041207*21.23)  # sucrose (kg/m3)
        self.rho2 = 998.  # water (kg/m3)
        self.D = 5.4e-10  # diffusion coefficient (m2 s-1)
        self.L = 0.02  # length of capillary (m)
        self.z0 = 0.01
        # Computed variables
        self.L_pos = self.L
        self.pos0 = self.L_pos-self.L
        self.z0_pos = self.z0+self.pos0
        self.N = N
        self.x_size = x_size
        
        self.x = np.linspace(self.pos0, self.L_pos, self.x_size)

    def rho_aprox(self, t):
        x = self.x-self.pos0
        density = (self.rho1*self.z0+self.rho2*(self.L-self.z0))/self.L
        for N0 in range(1, self.N):
            density += ((2./(N0*np.pi))*((self.rho1-self.rho2) *
                        np.sin((np.pi*N0*self.z0)/self.L)+self.rho2 *
                        np.sin(N0*np.pi))*np.cos(np.pi*(N0)*x/self.L) *
                        np.exp(-((np.pi*(N0)/self.L)**2*self.D*t)))
        return x, density


if __name__ == '__main__':
    basename1 = 'images1/plot_'
    basename2 = 'images2/plot_'
    basename3 = 'images3/plot_'
    evolver = DensityGradientEvolver()
    n_times = 500
    
    rhomin, rhomax = evolver.rho2, evolver.rho1
    
    maxtime=600 #in minutes
    inttime=3
    
    time_range = np.logspace(0, np.log10(maxtime*60), n_times)  #in seconds, logarithmic
    time_range = np.linspace(0.1, maxtime*60, n_times)  #in seconds
    
    tbegin=np.logspace(0,np.log10(inttime*60),70)
    tfinal=np.linspace(inttime*3+30, maxtime*60, n_times-70)
    
    time_range=np.concatenate([tbegin, tfinal])
    
    for (i,time) in enumerate(time_range):
        print (i,time)
        x_i, rho_i = evolver.rho_aprox(time)
        fig1, fig2, fig3 = plot_biplot(x_i,rho_i, rhomin, rhomax)
        name1 = basename1+str(i).zfill(4)
        fig1.savefig(name1,bbox_inches='tight',facecolor='None')#,dpi=150)

        name2 = basename2+str(i).zfill(4)
        fig2.savefig(name2,bbox_inches='tight',facecolor='None')#,dpi=150)

        name3 = basename3+str(i).zfill(4)
        fig3.savefig(name3,bbox_inches='tight',facecolor='None')#,dpi=150)


