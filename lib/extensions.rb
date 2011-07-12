# A class containing some extensions for the Float class. I found it online.
# @author Unknown
class Float
  
  # Rounds the float to x decimal places.
  #
  # @param [Integer] x The number of places after the decimal.
  # @return [Float] The original float rounded to x digits after the decimal.
  def round_to(x)
    (self * 10**x).round.to_f / 10**x
  end
end