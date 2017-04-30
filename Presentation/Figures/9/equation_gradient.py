import numpy as np
import matplotlib.pyplot as plt

def func(z,t):
    L=0.01          #10 cm
    R=10.e-9        #10 nm
    rho=2000.       # 2 g cm-3 = 2000 kg m-3 (SiO2 density)
    g=9.8           # 9.8 m s-2
    eta=8.9e-4      #viscosity of water (Pa s)
    KbT=1.38e22*298 #25C (J)
    
    pmin=0          #concentration of NPs
    pmax=100.
    
    zeta=6*np.pi*eta*R
    D=KbT/(zeta)
    m=rho*4*np.pi*R**3/3.
    xi=m*g/(2*D*zeta)
    k=np.pi/L
    lamb=D*(k**2+xi**2)
    
    print lamb, xi
    
    summation=0.
    eL2=np.exp(xi*L/2.)
    a0=2*eL2*(pmax*(1-np.exp(-xi*L/2.))+pmin*(eL2-1))/(L*xi)
    summation+=a0/2.
    for n in range(300):
            #print n
            Fn=2/(L*(xi**2+(k*n)**2))
            A=Fn*eL2*pmax
            B=Fn*eL2*pmin
            sin=np.sin(k*n*L/2.)
            cos=np.cos(k*n*L/2.)
            
            an=A*(xi*cos+k*n*sin-xi*np.exp(-xi*L/2))+B*(eL2*(xi*np.cos(k*n*L)+k*n*np.sin(k*n*L))-xi*cos-k*n*sin)
            bn=A*(xi*sin-k*n*cos+k*n*np.exp(-xi*L/2))+B*(eL2*(xi*np.sin(k*n*L)-k*n*np.cos(k*n*L))-xi*sin+k*n*cos)
            
            summation+=an*np.cos(k*n*z)+bn*np.sin(k*n*z)
    return np.exp(-lamb*t)*np.exp(-xi*z)*summation

zsim=np.linspace(0,0.01,1000)
for t in np.logspace(-9,-6,10): 
    print t
    plt.plot(zsim, func(zsim, t))
plt.show()