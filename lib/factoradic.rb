require_relative 'factoradic/version'

class Factoradic
  module ClassMethods
    def string_is_factoradic?(str)
      !!(str =~ /\A\d+([,:]\d+)+\Z/)
    end

    def autoconvert(str)
      if string_is_factoradic?(str)
        convert_factoradic_to_decimal(str)
      else
        convert_decimal_to_factoradic(str)
      end
    end

    def convert_factoradic_to_decimal(str)
      f = new
      f.parse_factoradic(str)
      f.to_i.to_s(10)
    end

    def convert_decimal_to_factoradic(str)
      f = new
      f.value = str.to_i(10)
      f.to_s
    end

    def valid_factoradic_digits?(digit_list)
      digit_list.reverse.map.with_index do |digit, idx|
        (digit >= 0) && (digit <= idx)
      end.all?(true)
    end

    def init_factorial_sequence!
      @factorial_sequence = [1]
    end

    def memoized_factorial(n)
      if @factorial_sequence.length > n
        @factorial_sequence[n]
      else
        @factorial_sequence[n] = n * memoized_factorial(n - 1)
      end
    end
  end
  extend ClassMethods
  self.init_factorial_sequence!

  def initialize
    @value = 0
    @digits = [0]
  end

  def recompute_digits!
    x = @value
    divisor = 2
    @digits = [0]

    while x > 0
      x, r = x.divmod(divisor)
      @digits.push(r)
      divisor += 1
    end

    @digits.reverse!
  end

  def recompute_value!
    @value = @digits.reverse.map.with_index do |digit, idx|
      digit * Factoradic.memoized_factorial(idx)
    end.reduce(&:+)
  end

  def [](i)
    @digits[i]
  end

  def []=(i, rvalue)
    new_places = @digits.dup
    new_places[i] = rvalue.to_i
    self.digits = new_digits
  end

  def parse_factoradic(str)
    self.digits = str.split(/[,:]/).map{ |x| x.to_i }
  end

  def digits=(new_digits)
    new_digits = new_digits.map do |x|
      if x.nil?
        0
      else
        x
      end
    end

    unless Factoradic.valid_factoradic_digits?(new_digits)
      raise ArgumentError, "Invalid factoradic digits."
    end

    @digits = new_digits
    recompute_value!
  end

  def value=(new_value)
    @value = new_value.to_i
    recompute_digits!
  end

  def to_s(separator = ':')
    @digits.join(separator)
  end

  def to_i
    @value
  end

  def inspect
    "#<Factoradic #{to_s}>"
  end
end
