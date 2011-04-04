#!/usr/bin/en python
"""
Example: simple line plot.
Show how to make and save a simple line plot with labels, title and grid
"""
import numpy
import pylab

rho = numpy.arange(0.0, 1.0+0.001, 0.001)
e = numpy.arccos(rho) / 3.14
Pr_E = e
Pr_B_m2 = (1/2.0) * (pow(1-e,3) + (1-e)*pow(e,2)) / ( pow(1-e,3) + 3*(1-e)*pow(e,2) )

#print e
#print Pr_B_m2

n=3
Pr_B_m3 = (1/2.0) * (pow(1-e,3*(n-1)) + pow((1-e), n-1)*(n-1)*pow(e,2))  /  (pow(1-e,3*(n-1)) + 3*(n-1)*pow((1-e),n-1) * pow(e,2))
n=4
Pr_B_m4 = (1/2.0) * (pow(1-e,3*(n-1)) + pow((1-e), n-1)*(n-1)*pow(e,2))  /  (pow(1-e,3*(n-1)) + 3*(n-1)*pow((1-e),n-1) * pow(e,2))

pylab.plot(e, Pr_E, e, Pr_B_m2, e, Pr_B_m3, e, Pr_B_m4, color='k')
#pylab.plot (e, Pr_B_m2, color='k')

#ylim(-1,4)
#pylab.yticks( numpy.arange(4), ['Pr E', 'Pr B m=2', 'Pr B m=3', 'Pr B m=4'])

pylab.xlabel("'rho' : overlap")
pylab.ylabel('Pa')
pylab.title('Probablity of attractive steps')
pylab.grid(True)
pylab.savefig('Pa_plot')

pylab.show()
