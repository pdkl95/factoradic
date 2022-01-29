require "test_helper"

class FactoradicTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Factoradic::VERSION
  end

  def test_convert_decimal_to_factoradic
    assert_equal Factoradic.d2f('0'),   '0'
    assert_equal Factoradic.d2f('1'), '1:0'

    assert_equal Factoradic.d2f('463'),   '3:4:1:0:1:0'
    assert_equal Factoradic.d2f('719'),   '5:4:3:2:1:0'
    assert_equal Factoradic.d2f('720'), '1:0:0:0:0:0:0'
  end

  def test_convert_factoradic_to_decimal
    assert_equal Factoradic.f2d(  '0'), '0'
    assert_equal Factoradic.f2d('1:0'), '1'

    assert_equal Factoradic.f2d(  '3:4:1:0:1:0'), '463'
    assert_equal Factoradic.f2d(  '5:4:3:2:1:0'), '719'
    assert_equal Factoradic.f2d('1:0:0:0:0:0:0'), '720'
  end
end
