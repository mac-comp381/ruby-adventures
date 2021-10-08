# ------ Base class with metaprogramming ------

class Animal
  def initialize(name)
    @name = name
  end

  attr_reader :name

  # Allow animal subclasses to specify `noise :name_of_noise`.
  # For example, a Dog might specify:
  #
  #   noise :bark
  #
  def self.noise(noise_name)
    # Here is what the following metaprogramming generates for `noise :bark`:

    # attr_reader :bark_mode   # ← getter method
    #
    # def barking?
    #   !bark_mode.nil?   # We're barking if bark_mode is not nil
    # end
    #
    # def stop_barking
    #   puts "#{@name} has stopped barking."
    #   @bark_mode = nil
    # end

    attr_name = "#{noise_name}_mode"

    attr_reader attr_name

    define_method("#{noise_name}ing?") do
      !send(attr_name).nil?
    end

    define_method("stop_#{noise_name}ing") do
      puts "#{@name} has stopped #{noise_name}ing."
      instance_variable_set("@" + attr_name, nil)
    end

    # Having specified a noise, subclasses define one or more variants
    # of that noise. For example, having specified `noise :bark`, Dog
    # could then specify:
    #
    #   bark_type :loudly
    #   bark_type :adorably

    # (What does `self.class.define_method` mean? Simply saying
    # `define_method` adds a new instance method to the Dog class.
    # Saying `self.class.define_method` adds a new method that is not
    # specific to any one Dog, but is available while defining the
    # Dog class itself.)
    #
    self.class.define_method("#{noise_name}_type") do |adverb|
      # Here is what the following metaprogramming generates for `bark_type :loudly`:

      # def bark_loudly!
      #   puts "#{@name} is barking loudly."
      #   @bark_mode = :loudly
      # end
      #
      # def barking_loudly?
      #   @bark_mode == :loudly
      # end

      define_method("#{noise_name}_#{adverb}!") do
        puts "#{@name} is #{noise_name}ing #{adverb}."
        instance_variable_set("@" + attr_name, adverb)
      end

      define_method("#{noise_name}ing_#{adverb}?") do
        send(attr_name) == adverb
      end
    end
  end
end

# ------ Class(es) that use the metaprogramming ------

class Duck < Animal
  noise :quack

  quack_type :softly
  quack_type :angrily
  quack_type :inscrutibly
  quack_type :ineluctibly
end

class Cat < Animal
  noise :meow
  meow_type :hungrily
  meow_type :pathetically

  noise :hiss
  hiss_type :disturbingly
  hiss_type :pathologically
end

# ------ Using the metaprogrammed classes ------

donald = Duck.new("Donald Duck")
donald.quack_softly!       # Q: Where are these methods declared?
donald.quack_inscrutibly!  # A: They aren’t declared! They’re metaprogrammed!
donald.stop_quacking

felix = Cat.new("Felix the Cat")
felix.meow_hungrily!       # Q: What does the ! mean?
felix.hiss_pathologically! # A: It’s just part of the method name.
felix.meow_pathetically!

puts "Felix meow mode: #{felix.meow_mode}"  # Q: How does the Cat class store this state?
puts "Felix hiss mode: #{felix.hiss_mode}"  # A: The metaprogramming creates an instance variable.

puts "Is Donald Duck quacking softly?"
p donald.quacking_softly?

puts "Is Felix meowing hungrily?"
p felix.meowing_hungrily?

puts "Is Felix hissing pathologically?"
p felix.hissing_pathologically?

puts "Full state of both objects:"
p donald
p felix
