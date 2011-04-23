import numpy
import pylab

N = 1000
m = 2

def get_avg(fname):
	f = open(fname)
	sum = 0;
	n = 0;
	for l in f.readlines():
		 sum += int(l.split()[2])
		 n += 1
	avg = sum/float(n)
	return avg


Lrange = numpy.arange(0.0, 8.0+1.0, 1.0)


K = 3
k3 = []
for L in Lrange:
	try:
		k3.append(get_avg('log_K={0}_L={1}_N={2}_m={3}.txt'.format (K,L,N,m) ));
	except IOError:
 		k3.append(None)
k3array = numpy.array(k3)


K = 4
k4 = []
for L in Lrange:
	try:
		k4.append(get_avg('log_K={0}_L={1}_N={2}_m={3}.txt'.format (K,L,N,m) ));
	except IOError:
 		k4.append(None)
k4array = numpy.array(k4)


K = 5
k5 = []
for L in Lrange:
	try:
		k5.append(get_avg('log_K={0}_L={1}_N={2}_m={3}.txt'.format (K,L,N,m) ));
	except IOError:
 		k5.append(None)
k5array = numpy.array(k5)


K = 6
k6 = []
for L in Lrange:
	try:
		k6.append(get_avg('log_K={0}_L={1}_N={2}_m={3}.txt'.format (K,L,N,m) ));
	except IOError:
 		k6.append(None)
k6array = numpy.array(k6)



pylab.plot( L, k3array, 'ro--',L, k4array, 'bo--', L, k5array, 'go--', L, k6array, 'ko--')

pylab.xlabel("L", bbox=dict(facecolor='red', alpha=0.5))
pylab.ylabel('avg tsync')
pylab.title('tsync vs L for m=3, N=11 [tync averaged over atleast 50 runs]')
pylab.grid(True)
pylab.savefig('Tsync_vs_L_plot[N=11,m=3]')

pylab.show()
