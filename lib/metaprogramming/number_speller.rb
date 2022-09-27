# ------ Class with metaprogramming ------

class NumberSpeller
  def initialize(base:, value: 0)
    if base > DIGIT_NAMES.length
      raise "Max supported base is #{DIGIT_NAMES.length}"
    end
    @base = base
    @value = value
  end

  def method_missing(name, *args)  # This method is the truly interesting part!
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

  decimal_digits = %i(zero one two three four five six seven eight nine)

  DIGIT_NAMES = [
    decimal_digits,
    %i(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen),
    %w(
      twenty thirty forty fifty sixty seventy eighty ninety
    ).product(decimal_digits).map do |tens, ones|
      "#{tens}_#{ones}"
        .delete_suffix('_zero')  # we want "twenty" instead of "twenty_zero"
        .to_sym
    end
  ].flatten.freeze
end

puts "------ All available digit names ------ "

NumberSpeller::DIGIT_NAMES.each.with_index do |name, i|
  puts "#{i} #{name}"
end

puts
puts "------ Code that uses the metaprogramming ------"

binary      = NumberSpeller.new(base: 2)
decimal     = NumberSpeller.new(base: 10)
hex         = NumberSpeller.new(base: 16)
sexagesimal = NumberSpeller.new(base: 60)

puts <<_EOS_

  one.one.zero.one in...
    binary:  #{ binary.one.one.zero.one}
    decimal: #{decimal.one.one.zero.one}
    hex:     #{    hex.one.one.zero.one}

  COMP #{binary.one.one.one.one.one.one.one} is in OLRI #{hex.one.zero.zero}
  COMP #{decimal.three.eight.one} is in OLRI #{sexagesimal.four.fourteen}

  The Sumerians used sexagesimal. And guess what? So do we!
  It still shows up in our modern-day time and angle units.
  For example, 11:48 AM is #{sexagesimal.eleven.forty_eight} minutes into the day,
  and there are #{sexagesimal.six.zero} degrees in a circle.

_EOS_
