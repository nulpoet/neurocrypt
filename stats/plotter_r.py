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
Pr_B_m2 = 2 * (1-e)*pow(e,2) / ( pow(1-e,3) + 3*(1-e)*pow(e,2) )
n=3
Pr_B_m3 = 2*(n-1)*pow((1-e), n-1)*pow(e,2)  /  (pow(1-e,3*(n-1)) + 3*(n-1)*pow((1-e),n-1) * pow(e,2))
n=4
Pr_B_m4 = 2*(n-1)* pow((1-e), n-1) * pow(e,2) / (pow(1-e,3*(n-1)) + 3*(n-1)*pow((1-e),n-1) * pow(e,2))

pylab.plot(e, Pr_E, e, Pr_B_m2, e, Pr_B_m3, e, Pr_B_m4, color='k')
#ylim(-1,4)
#pylab.yticks( numpy.arange(4), ['Pr E', 'Pr B m=2', 'Pr B m=3', 'Pr B m=4'])

pylab.xlabel("'rho' : overlap")
pylab.ylabel('Pr')
pylab.title('Probablity of repulsive steps')
pylab.grid(True)
pylab.savefig('Pr_plot')

pylab.show()
