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


L = numpy.arange(0.0, 10.0+1.0, 1.0)


if __name__ == '__main__':
	
	print get_avg('logs/m3/log_k3_l4_n11_m3_1000.txt');
	print get_avg('logs/m3/log_k3_l5_n11_m3_100.txt');
	print get_avg('logs/m3/log_k3_l6_n11_m3_100.txt');
	
	print "main"
