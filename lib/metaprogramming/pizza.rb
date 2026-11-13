#Base class with metaprogramming

class Pizza
  def initialize
    @toppings = []
  end

  # `topping :cheese` creates two methods: add_cheese! and has_cheese?
  #
  def self.topping(*names)
    names.each do |name|
      define_method("add_#{name}!") do
        @toppings << name
        puts "Added #{name}."
      end

      define_method("has_#{name}?") do
        @toppings.include?(name)
      end
    end
  end
end

#myu classes that use the metaprogramming 

class Pizza
  topping :cheese, :olives, :mushrooms, :pineapple
end


# Using the metaprogrammed class 

my_pizza = Pizza.new
my_pizza.add_cheese!       
my_pizza.add_pineapple!    

puts "Has cheese?"
p my_pizza.has_cheese?

puts "Has olives?"
p my_pizza.has_olives?
