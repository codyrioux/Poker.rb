# A basic probability distribution class for
# holding objects and their associated probabilities.
#
# This class behaves just like a hash where the key is the object
# and the value of the entry is the probability.
#
# @author Cody Rioux
# 
class ProbabilityDistribution < Hash

	def cumulative_density
		sum = 0.0
		self.each { |key, val| sum += val }
		return sum
	end

	def get_normalized_probability_of(key)
		self[key] / cumulative_density
	end

	def normalize
		density = cumulative_density
		self.each do |key, val|
			self[key] = self[key] / density
		end
	end

	def ev
		self.normalize
		sum = 0.0
		self.each do |key, val|
			sum += (key * val)
		end
		return sum
	end

	def variance(trials = 1)
		expectedValue = self.ev	
		sum = 0.0
		self.each do |key, val|
			sum += val * ((key - expectedValue)**2)	
		end
		return sum * trials
	end
end
