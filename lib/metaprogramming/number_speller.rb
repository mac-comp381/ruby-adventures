# ------ Class with metaprogramming ------

class NumberSpeller
  def initialize(base:, value: 0)
    if base > DIGIT_NAMES.length
      raise "Max supported base is #{DIGIT_NAMES.length}"
    end
    @base = base
    @value = value
  end

  def method_missing(name, *args)
    if digit = DIGIT_NAMES.index(name)
      NumberSpeller.new(
        base: @base,
        value: @value * @base + digit)
    else
      super
    end
  end

  def to_i
    @value
  end

  def to_s
    to_i.to_s
  end

  DIGIT_NAMES = %i(
    zero one two three four five six seven eight nine ten
    eleven twelve thirteen fourteen fifteen
  )
end

# ------ Code that uses the metaprogramming ------

binary = NumberSpeller.new(base: 2)
decimal = NumberSpeller.new(base: 10)
hex = NumberSpeller.new(base: 16)

puts "COMP #{decimal.three.eight.one} is in OLRI #{hex.fifteen.fourteen}"

puts "--- one.one.zero.one ---"
puts "binary:  #{ binary.one.one.zero.one}"
puts "decimal: #{decimal.one.one.zero.one}"
puts "hex:     #{    hex.one.one.zero.one}"
