require 'test/unit'
require 'icm.rb'

class TestIcm < Test::Unit::TestCase
  
  def test_equity_even_oppoent_stacks
    payouts = [ 0.5, 0.3, 0.2 ]
    other_stacks = [4500, 4500, 4500]
    
    assert_equal(0.2627, Icm.equity(payouts, other_stacks, 5000).round_to(4))
    assert_equal(0.4605, Icm.equity(payouts, other_stacks, 60000).round_to(4))
    assert_equal(0.0929, Icm.equity(payouts, other_stacks, 1000).round_to(4))
    assert_equal(0.0011, Icm.equity(payouts, other_stacks, 10).round_to(4))
  end
  
  def test_equity_bubble
    payouts = [ 0.5, 0.3, 0.2 ]
    
    assert_equal(0.3383, Icm.equity(payouts, [2800, 3900, 5000] , 8300).round_to(4))
    assert_equal(0.1738, Icm.equity(payouts, [8300, 3900, 5000] , 2800).round_to(4))
    assert_equal(0.2250, Icm.equity(payouts, [8300, 2800, 5000] , 3900).round_to(4))
    assert_equal(0.2629, Icm.equity(payouts, [8300, 2800, 3900] , 5000).round_to(4))
  end
  
  def test_equity_bubble2
    payouts = [ 0.5, 0.3, 0.2 ]
    
    assert_equal(0.3394, Icm.equity(payouts, [5300, 3900, 2500] , 8300).round_to(4))
    assert_equal(0.2736, Icm.equity(payouts, [8300, 3900, 2500] , 5300).round_to(4))
    assert_equal(0.2274, Icm.equity(payouts, [8300, 5300, 2500] , 3900).round_to(4))
    assert_equal(0.1596, Icm.equity(payouts, [8300, 5300, 3900] , 2500).round_to(4))
  end
  
  def test_bubble_factor
    payouts = [ 0.5, 0.3, 0.2 ]
    other_stacks = [8300, 3900]
    
    assert_equal(1.24, Icm.bubble_factor(payouts, other_stacks, 5300, 2500).round_to(2))
  end
end