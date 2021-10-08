# ------ Class with metaprogramming ------

class NumberSpeller
  def initialize(base)
    if base > DIGIT_NAMES.length
      raise "Max supported base is #{DIGIT_NAMES.length}"
    end
    @base = base
  end

  def method_missing(name, *args)
    result = 0
    name.to_s.split("_").each do |digit|
      digit_index = DIGIT_NAMES.index(digit)
      raise "Unknown digit name: #{name}" unless digit_index
      result = result * @base + digit_index
    end
    return result
  end

  DIGIT_NAMES = %w(
    zero one two three four five six seven eight nine ten
    eleven twelve thirteen fourteen fifteen
  )
end

# ------ Code that uses the metaprogramming ------

binary = NumberSpeller.new(2)
decimal = NumberSpeller.new(10)
hex = NumberSpeller.new(16)

puts "COMP #{decimal.three_eight_one} is in OLRI #{hex.fifteen_fourteen}"

puts "--- one_one_zero_one ---"
puts "binary:  #{binary.one_one_zero_one}"
puts "decimal: #{decimal.one_one_zero_one}"
puts "hex:     #{hex.one_one_zero_one}"
