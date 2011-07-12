require 'extensions.rb'

# A class containing ICM (Independent Chip Model) related functions.
# @author Cody Rioux
class Icm

	# Computes the player's equity using ICM given the current state of the tournament.
	#
	# @todo Change the other_stacks.each to pass in a subset of other_stacks to the recursive
	#       call instead of setting the specific element to 0.
	#
	# @param [Array] payouts A list of the payouts for the tournament. Ex: [ 0.5, 0.3, 0.2]
	# @param [Array] other_stacks A list of the stacks of all the other players.
	# @param [Float] player_stack The player in question's stack size.
	# @param [Float] depth A parameter to keep track of recursion depth, defaults to zero.
	# @return [Float] The player's equity in the tournament expressed as a percentage.
	def self.equity(payouts, other_stacks, player_stack, depth = 0)
		total = other_stacks.inject(0) { |sum, stack| sum + stack } + player_stack
		eq = player_stack.to_f / total.to_f * payouts[depth]
		if depth + 1 < payouts.size()
			other_stacks.each_index do |i|
				c = other_stacks[i]
				other_stacks[i] = 0
				eq += equity(payouts, other_stacks, player_stack, depth + 1) * c / total unless c == 0
				other_stacks[i] = c
			end
		end
		return eq
	end

	# Calculates the player's bubble factor vs another player.
	# 
	# @param [Array] payouts A list of the payouts for the tournament. Ex: [ 0.5, 0.3, 0.2]
	# @param [Array] other_stacks A list of the stacks of all the other players.
	# @param [Float] player_a The stack size of the player to calculate bubble factor for.
	# @param [Float] player_b The stack size of the player to calculate bubble factor against.
	# @return [Float] A decimal number representing player a's bubble factor vs player b.
	def self.bubble_factor(payouts, other_stacks, player_a, player_b)
		other_stacks.push(player_b)
		eq_player_a = equity(payouts, other_stacks, player_a)
		other_stacks.pop

		if (player_a >= player_b)
			other_stacks.push(0)
			eq_player_a_wins = equity(payouts, other_stacks, player_a + player_b)
			other_stacks.pop

			other_stacks.push(player_b * 2)
			eq_player_a_loses = equity(payouts, other_stacks, player_a - player_b)
		else
			other_stacks.push(player_b - player_a)
			eq_player_a_wins = equity(payouts, other_stacks, player_a * 2)
			other_stacks.pop
                        eq_player_a_loses = 0
		end

		return (eq_player_a - eq_player_a_loses) / (eq_player_a_wins - eq_player_a)
	end
end
