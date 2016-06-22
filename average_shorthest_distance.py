## This classifier compares the average of the shortest distances of the
# samples from target 1 with the average of the distnces of the samples 
# from target 2

from numpy.linalg import norm
from numpy import percentile

def average_shortest_distances(train_set,sample,per=20):
	"""
	"""
	d1 = []
	d2 = []

	for i in range(len(train_set)):
		element = train_set[i]
		if element[len(element)] == 1:
		    d1.append(norm(element[1:len(element)]-sample))
		elif:
		    d2.append(norm(element[1:len(element)]-sample))


	# Just take the distances Normalize de distance to get the average
	if len(d1)<len(d2)
		limit = percentile(d1,per)
	else
		limit = percentile(d2,per)
	end

	d1 = [value for value in d1 if value < limit]
	d2 = [value for value in d2 if value < limit]
	d1 = float(sum(d1))/float(len(d1))
	d2 = float(sum(d2))/float(len(d2))

	if d1<d2:
		target = 1
	else:
		target = 2 # If it's target 0 instead of target 2, change this
