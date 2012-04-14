import numpy
import pylab
import os
import fnmatch

def get_avg(fname_pre):

	fname = ""
	for file in os.listdir('.'):
		if fnmatch.fnmatch(file, fname_pre+'*.txt'):
			fname = file

	f = open(fname)

	sum = 0;
	n = 0;
	for l in f.readlines():
		 sum += int(l.split()[2])
		 n += 1
	avg = sum/float(n)
	return avg


L = numpy.arange(0.0, 10.0+1.0, 1.0)


# K = 3
k3 = []
for i in L:
	try:
		k3.append(get_avg('log_K=3_L='+str(int(i))+'_N=1000_m=3'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=3_L='+str(int(i))+'_N=11_m=3.txt'
		k3.append(None)
k3array = numpy.array(k3)


# K = 4
k4 = []
for i in L:
	try:
		k4.append(get_avg('log_K=4_L='+str(int(i))+'_N=1000_m=3'));
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=4_L='+str(int(i))+'_N=11_m=3.txt'
		k4.append(None)
k4array = numpy.array(k4)


# K = 5
k5 = []
cnt = -1
for i in L:
	try:
		cnt += 1
		if cnt > 5:
			raise IOError
		k5.append(get_avg('log_K=5_L='+str(int(i))+'_N=1000_m=3'))
	except IOError:
#		print 'NOT FOUND :: ' + 'log_K=4_L='+str(int(i))+'_N=11_m=3.txt'
		k5.append(None)
k5array = numpy.array(k5)


pylab.plot( L, k3array, 'ro--',L, k4array, 'bo--', k5array, 'ko--')

f = open('tsync_vs_L.txt','w')
f.write("\n\n[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 , 10 ]\n")
f.write("\n\nK=3 \n" +str(k3array))
f.write("\n\nK=4 \n" +str(k4array))
f.write("\n\nK=5 \n" +str(k5array))
f.close()

pylab.xlabel("L")
pylab.ylabel('avg tsync')
pylab.title('tsync vs L for m=3, N=1000')
pylab.grid(True)
pylab.savefig('Tsync[cropped]_vs_L_plot[N=1000,m=3]')

pylab.show()
