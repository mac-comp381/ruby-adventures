# ------ Base class with metaprogramming ------

class Object
  # A simple version of Ruby’s built-in attr_accessor.
  #
  def self.property(*prop_names)  # the asterisk means zero or more arguments
    prop_names.each do |prop_name|
      ivar_name = "@#{prop_name}"

      # Getter
      define_method(prop_name) do
        instance_variable_get(ivar_name)
      end

      # Setter
      define_method("#{prop_name}=") do |new_value|
        instance_variable_set(ivar_name, new_value)
      end
    end
  end
end

# ------ Class(es) that use the metaprogramming ------

class IceCreamCone
  property :flavor, :container
end

# ------ Using the metaprogrammed classes ------

cone0 = IceCreamCone.new
cone0.flavor = "double chocolate"
cone0.container = "waffle cone"

cone1 = IceCreamCone.new
cone1.flavor = "cardamom rosewater"
cone1.container = "dish"

[cone0, cone1].each do |cone|
  puts "#{cone.flavor} in a #{cone.container}"
end
