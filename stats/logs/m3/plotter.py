import numpy
import pylab

def get_avg(fname):
	f = open(fname)

	sum = 0;
	n = 0;
	for l in f.readlines():
		 sum += int(l.split()[2])
		 n += 1
	avg = sum/float(n)
	return avg


L = numpy.arange(0.0, 8.0+1.0, 1.0)

# K = 3
k3 = []
for i in L:
	try:
		k3.append(get_avg('log_K=3_L='+str(int(i))+'_N=11_m=3.txt'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=3_L='+str(int(i))+'_N=11_m=3.txt'
		k3.append(None)
k3array = numpy.array(k3)

# K = 4
k4 = []
for i in L:
	try:
		k4.append(get_avg('log_K=4_L='+str(int(i))+'_N=11_m=3.txt'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=4_L='+str(int(i))+'_N=11_m=3.txt'
		k4.append(None)
k4array = numpy.array(k4)

# K = 5
k5 = []
for i in L:
	try:
		k5.append(get_avg('log_K=5_L='+str(int(i))+'_N=11_m=3.txt'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=4_L='+str(int(i))+'_N=11_m=3.txt'
		k5.append(None)
k5array = numpy.array(k5)

# K = 4
k6 = []
for i in L:
	try:
		k6.append(get_avg('log_K=6_L='+str(int(i))+'_N=11_m=3.txt'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=4_L='+str(int(i))+'_N=11_m=3.txt'
		k6.append(None)
k6array = numpy.array(k6)


pylab.plot( L, k3array, 'ro--',L, k4array, 'bo--', L, k5array, 'go--', L, k6array, 'ko--')

pylab.xlabel("L", bbox=dict(facecolor='red', alpha=0.5))
pylab.ylabel('avg tsync')
pylab.title('tsync vs L for m=3, N=11 [tync averaged over atleast 50 runs]')
pylab.grid(True)
pylab.savefig('Tsync_vs_L_plot[N=11,m=3]')

pylab.show()
