import numpy as np
from pylab import *



def histOutline(dataIn, *args, **kwargs):
     (histIn, binsIn) = np.histogram(dataIn, *args, **kwargs)
 
     stepSize = binsIn[1] - binsIn[0]
 
     bins = np.zeros(len(binsIn)*2 + 2, dtype=np.float)
     data = np.zeros(len(binsIn)*2 + 2, dtype=np.float)
     for bb in range(len(binsIn)):
         bins[2*bb + 1] = binsIn[bb]
         bins[2*bb + 2] = binsIn[bb] + stepSize
         if bb < len(histIn):
             data[2*bb + 1] = histIn[bb]
             data[2*bb + 2] = histIn[bb]
 
     bins[0] = bins[1]
     bins[-1] = bins[-2]
     data[0] = 0
     data[-1] = 0
 
     return (bins, data)



data_m2 = []

f = open('log_k3_l4_n11_nm2_1000.txt')
for l in f.readlines():
	data_m2.append( int(l.split()[2]) )


data_m3 = []

f = open('log_k3_l4_n11_nm3_1000.txt')
for l in f.readlines():
	data_m3.append( int(l.split()[2]) )

#data = randn(500)

#print data

#figure(2, figsize=(10, 5))
#clf()

##########
#
# First make a normal histogram
#
##########
#subplot(1, 2, 1)
#(n, bins, patches) = hist(data)

# Boundaries
#xlo = -max(abs(bins))
#xhi = max(abs(bins))
#ylo = 0
#yhi = max(n) * 1.1

#axis([xlo, xhi, ylo, yhi])

##########
#
# Now make a histsogram in outline format
#
##########
(bins_m2, n_m2) = histOutline(data_m2)
(bins_m3, n_m3) = histOutline(data_m3)
#subplot(1, 2, 2)
plot(bins_m2, n_m2, 'b-', bins_m3, n_m3, 'k-')

# Boundaries
xlo = min( abs(bins_m3))
xhi = max( abs(bins_m2))
ylo = 0
yhi = max(n_m3) * 1.1
axis([xlo, xhi, ylo, yhi])

title('Tsync for 3 Neural Machines vs 2 Neural Machines')
grid(True)
savefig('tsync_histogram_m2_vs_m3')


show()
