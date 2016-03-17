set log

A(q, eps1,eps2) = ((R0+eps1)*(R0+eps2) + sR**2)*cos(q*(eps1-eps2))
B(q, eps1, eps2) = exp(-2*q**2*sR**2) * ((R0+eps1)*(R0+eps2)+sR**2-4*q**2*sR**4) 	* cos(q*(2*R0+eps1+eps2))
C(q, eps1, eps2) = 2*sR**2*q*exp(-2*q**2*sR**2)*(2*R0+eps1+eps2)*sin(q*(2*R0+eps1+eps2))
D(q, rho1,sigma1,rho2,sigma2) = rho1*rho2*sigma1*sigma2*exp(-q**2*(sigma1**2+sigma2**2)/2)
T(q, r1,s1,e1,r2,s2,e2) = D(q, r1, s1, r2, s2)*(A(q, e1, e2) - B(q, e1, e2) + C(q, e1, e2))
vesicle(q) = 2.0/(q**2)*( 	T(q, r1,s1,e1, r1,s1,e1) + 	T(q, r1,s1,e1, r2,s2,e2) + 	T(q, r1,s1,e1, r3,s3,e3) + 	T(q, r1,s1,e1, r4,s4,e4) + 	T(q, r1,s1,e1, r5,s5,e5) + 	T(q, r2,s2,e2, r1,s1,e1) + 	T(q, r2,s2,e2, r2,s2,e2) + 	T(q, r2,s2,e2, r3,s3,e3) + 	T(q, r2,s2,e2, r4,s4,e4) + 	T(q, r2,s2,e2, r5,s5,e5) + 	T(q, r3,s3,e3, r1,s1,e1) + 	T(q, r3,s3,e3, r2,s2,e2) + 	T(q, r3,s3,e3, r3,s3,e3) + 	T(q, r3,s3,e3, r4,s4,e4) + 	T(q, r3,s3,e3, r5,s5,e5) + 	T(q, r4,s4,e4, r1,s1,e1) + 	T(q, r4,s4,e4, r2,s2,e2) + 	T(q, r4,s4,e4, r3,s3,e3) + 	T(q, r4,s4,e4, r4,s4,e4) + 	T(q, r4,s4,e4, r5,s5,e5) + 	T(q, r5,s5,e5, r1,s1,e1) + 	T(q, r5,s5,e5, r2,s2,e2) + 	T(q, r5,s5,e5, r3,s3,e3) + 	T(q, r5,s5,e5, r4,s4,e4) + 	T(q, r5,s5,e5, r5,s5,e5))
gauss(x, r, sigma) = exp(-(x-r)**2/(2.0*sigma**2))
edensity(x)= r1*gauss(x, R0+e1, s1) + r2*gauss(x, R0+e2, s2) +r3*gauss(x, R0+e3, s3) + 	r4*gauss(x, R0+e4, s4) + r5*gauss(x, R0+e5, s5)
GNUTERM = "qt"
R0 = 21.0474769659297
sR = 6.51225818468771
GPFUN_A = "A(q, eps1,eps2) = ((R0+eps1)*(R0+eps2) + sR**2)*cos(q*(eps1-eps2))"
GPFUN_B = "B(q, eps1, eps2) = exp(-2*q**2*sR**2) * ((R0+eps1)*(R0+eps2)+sR**2-4*q**2*sR**4) \t* cos(q*(2*R0+eps1+eps2))"
GPFUN_C = "C(q, eps1, eps2) = 2*sR**2*q*exp(-2*q**2*sR**2)*(2*R0+eps1+eps2)*sin(q*(2*R0+eps1+eps2))"
GPFUN_D = "D(q, rho1,sigma1,rho2,sigma2) = rho1*rho2*sigma1*sigma2*exp(-q**2*(sigma1**2+sigma2**2)/2)"
GPFUN_T = "T(q, r1,s1,e1,r2,s2,e2) = D(q, r1, s1, r2, s2)*(A(q, e1, e2) - B(q, e1, e2) + C(q, e1, e2))"
r1 = 1.45991718882693
s1 = 2.41241867719329
e1 = -7.43474342072835
r2 = 1.0
s2 = 1.27954792394523
e2 = -2.75014545729523
r3 = -2.23727558504215
s3 = 5.88953269237405
e3 = 0.0
r4 = 1.0
s4 = 3.05365372988556
e4 = 1.19940529355439
r5 = 1.07541285242368
s5 = 5.35166955536875
e5 = 3.22646209098938
GPFUN_vesicle = "vesicle(q) = 2.0/(q**2)*( \tT(q, r1,s1,e1, r1,s1,e1) + \tT(q, r1,s1,e1, r2,s2,e2) + \tT(q, r1,s1,e1, r3,s3,e3) + \tT(q, r1,s1,e1, r4,s4,e4) + \tT(q, r1,s1,e1, r5,s5,e5) + \tT(q, r2,s2,e2, r1,s1,e1) + \tT(q, r2,s2,e2, r2,s2,e2) + \tT(q, r2,s2,e2, r3,s3,e3) + \tT(q, r2,s2,e2, r4,s4,e4) + \tT(q, r2,s2,e2, r5,s5,e5) + \tT(q, r3,s3,e3, r1,s1,e1) + \tT(q, r3,s3,e3, r2,s2,e2) + \tT(q, r3,s3,e3, r3,s3,e3) + \tT(q, r3,s3,e3, r4,s4,e4) + \tT(q, r3,s3,e3, r5,s5,e5) + \tT(q, r4,s4,e4, r1,s1,e1) + \tT(q, r4,s4,e4, r2,s2,e2) + \tT(q, r4,s4,e4, r3,s3,e3) + \tT(q, r4,s4,e4, r4,s4,e4) + \tT(q, r4,s4,e4, r5,s5,e5) + \tT(q, r5,s5,e5, r1,s1,e1) + \tT(q, r5,s5,e5, r2,s2,e2) + \tT(q, r5,s5,e5, r3,s3,e3) + \tT(q, r5,s5,e5, r4,s4,e4) + \tT(q, r5,s5,e5, r5,s5,e5))"
GPFUN_gauss = "gauss(x, r, sigma) = exp(-(x-r)**2/(2.0*sigma**2))"
GPFUN_edensity = "edensity(x)= r1*gauss(x, R0+e1, s1) + r2*gauss(x, R0+e2, s2) +r3*gauss(x, R0+e3, s3) + \tr4*gauss(x, R0+e4, s4) + r5*gauss(x, R0+e5, s5)"
R = 20.0
N = 3.64392032805767
c = 774.891488731041
FIT_CONVERGED = 0
FIT_NDF = 224
FIT_STDFIT = 1.38921758703802
FIT_WSSR = 432.303312926403
set xlabel '$q$ / nm$^{-1}$'
set ylabel 'Scattering Intensity / a.u.'
set xrange [0.035:1.]
set yrange [0.4:500]

p 'caelyx_water.dat' every 2 u ($1<0.1?$1:1/0):($2/1.e12) w p ls 1 t 'Caelyx in buffer','' every 4 u (($1<0.2)&&($1>0.1)?$1:1/0):($2/1e12) w p ls 1 notitle,'' every 6 u (($1>0.2)?$1:1/0):($2/1e12) w p ls 1 notitle, "caelyx_iodixanol_9.1.dat" every 2 u ($1<0.1?$1:1/0):($2/1.e12) w p ls 2 t 'Caelyx in 9.1$\%$ iodixanol','' every 4 u (($1<0.2)&&($1>0.1)?$1:1/0):($2/1e12) w p ls 2 notitle,'' every 6 u (($1>0.2)?$1:1/0):($2/1e12) w p ls 2 notitle, 'SSL_water.dat' every 2 u (($1<0.1)?$1:1/0):($2/2e12) w p ls 3 t 'SSL in buffer','' every 4 u (($1<0.2)&&($1>0.1)?$1:1/0):($2/2e12) w p ls 3 notitle,'' every 6 u (($1>0.2)?$1:1/0):($2/2e12) w p ls 3 notitle,(N*vesicle(x)+c)*1e9/1e12 w l ls 1 t 'Vesicle fit'