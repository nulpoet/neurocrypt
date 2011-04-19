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

	print "m3 k3"	
	print get_avg('logs/n1000/log_K=3_L=1_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=2_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=3_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=4_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=5_N=1000_m=3_r=100.txt');


	print "m2 k3"	
	print get_avg('logs/n1000/log_K=3_L=1_N=1000_m=2_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=2_N=1000_m=2_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=3_N=1000_m=2_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=4_N=1000_m=2_r=100.txt');
	print get_avg('logs/n1000/log_K=3_L=5_N=1000_m=2_r=100.txt');

	print "m3 k4"	
	print get_avg('logs/n1000/log_K=4_L=2_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=4_L=3_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=4_L=4_N=1000_m=3_r=100.txt');
	print get_avg('logs/n1000/log_K=4_L=5_N=1000_m=3_r=100.txt');
	
	print "main"
