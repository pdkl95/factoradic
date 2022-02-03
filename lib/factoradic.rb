require_relative 'factoradic/version'

require 'ostruct'

class Factoradic
  DEFAULT_OPTIONS = {
    # disabling this will save ram when computing
    # very large (Bignum) factorial values
    memoize_factorial_values: true,

    # the separator used between placex in factorial base
    separator: ':'
  }

  @options = OpenStruct.new(DEFAULT_OPTIONS)

  # cache of basic factorial vslues
  @factorial_sequence = [1]

  class << self
    attr_accessor :options

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
    alias f2d convert_factoradic_to_decimal

    def convert_decimal_to_factoradic(decimal)
      intvalue = case decimal
                 when Integer
                   decimal
                 when String
                   decimal.to_i(10)
                 else
                   raise ArgumentError, "Expected an Integer or String{"
                 end

      f = new
      f.value = intvalue
      f.to_s
    end
    alias d2f convert_decimal_to_factoradic

    def valid_factoradic_digits?(digit_list)
      digit_list.reverse.map.with_index do |digit, idx|
        (digit >= 0) && (digit <= idx)
      end.all?(true)
    end

    def memoized_factorial(n)
      if @factorial_sequence.length > n
        @factorial_sequence[n]
      else
        @factorial_sequence[n] = n * memoized_factorial(n - 1)
      end
    end

    def basic_factorial(n)
      (1..n).reduce(1, :*)
    end

    def factorial(n)
      if options.memoize_factorial_values
        memoized_factorial(n)
      else
        basic_factorial(n)
      end
    end
  end

  def initialize
    @value = 0
    @digits = [0]
  end

  def options
    self.class.options
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
      digit * Factoradic.factorial(idx)
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

  def to_s(separator = options.separator)
    @digits.join(separator)
  end

  def to_i
    @value
  end

  def inspect
    "#<Factoradic #{to_s}>"
  end
end
