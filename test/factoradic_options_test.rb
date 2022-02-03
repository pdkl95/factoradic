require "test_helper"

class FactoradicOptionsTest < Minitest::Test
  def setup
    @orig_options = Factoradic.options.dup    
  end

  def cleanup
    Factoradic.options = @orig_options
  end

  def test_modified_output_separator
    Factoradic.options.separator = ','
    assert_equal Factoradic.d2f('463'),   '3,4,1,0,1,0'
    assert_equal Factoradic.d2f('719'),   '5,4,3,2,1,0'
    assert_equal Factoradic.d2f('720'), '1,0,0,0,0,0,0'    
  end

  def common_factorial_tests
    assert_equal Factoradic.f2d(  '0'), '0'
    assert_equal Factoradic.f2d('1:0'), '1'

    assert_equal Factoradic.f2d(  '3:4:1:0:1:0'), '463'
    assert_equal Factoradic.f2d(  '5:4:3:2:1:0'), '719'
    assert_equal Factoradic.f2d('1:0:0:0:0:0:0'), '720'
  end

  def test_without_memoized_factorial
    Factoradic.options.memoize_factorial_values = false
    common_factorial_tests
  end

  def test_with_memoized_factorial
    Factoradic.options.memoize_factorial_values = true
    common_factorial_tests
  end
end
