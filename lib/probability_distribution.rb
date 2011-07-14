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
end
