# ------ Base class with metaprogramming ------

class Character
  def initialize(name)
    @name = name
  end

  attr_reader :name

  def self.attack(attack_name)

    attr_name = "#{attack_name}_mode"

    attr_reader attr_name

    define_method("#{attack_name}ing?") do
      !send(attr_name).nil?
    end

    define_method("stop_#{attack_name}ing") do
      puts "#{@name} has stopped #{attack_name}ing."
      instance_variable_set("@" + attr_name, nil)
    end

    self.class.define_method("#{attack_name}_type") do |battle_option|

      define_method("#{attack_name}_with_#{battle_option}!") do
        puts "#{@name} is #{attack_name}ing using their #{battle_option}."
        instance_variable_set("@" + attr_name, battle_option)
      end

      define_method("#{attack_name}ing_with_#{battle_option}?") do
        send(attr_name) == battle_option
      end
    end
  end

  def self.movement(movement_name)

    attr_name = "#{movement_name}_mode"

    attr_reader attr_name

    define_method("#{movement_name}ing?") do
      !send(attr_name).nil?
    end

    define_method("stop_#{movement_name}ing") do
      puts "#{@name} has stopped #{movement_name}ing."
      instance_variable_set("@" + attr_name, nil)
    end

    self.class.define_method("#{movement_name}_type") do |adverb|

      define_method("#{movement_name}_#{adverb}!") do
        puts "#{@name} is #{movement_name}ing #{adverb}."
        instance_variable_set("@" + attr_name, adverb)
      end

      define_method("#{movement_name}ing_#{adverb}?") do
        send(attr_name) == adverb
      end
    end
  end
end

# ------ Class(es) that use the metaprogramming ------

class Standard < Character
  movement :sprint

  sprint_type :loudly
  sprint_type :quickly

  attack :bonk
  bonk_type :claymore
  bonk_type :skill
  bonk_type :burst
end

class Non_Standard < Character
  movement :alt_sprint
  alt_sprint_type :rapidly
  alt_sprint_type :stealthily

  movement :walk
  walk_type :calmly
  walk_type :carefully

  attack :pummel
  pummel_type :polearm
  pummel_type :sprint_attack
end

# ------ Using the metaprogrammed classes ------
diluc = Standard.new("Diluc Ragnvindr")
diluc.sprint_quickly!       
diluc.sprint_loudly!  
diluc.stop_sprinting
diluc.bonk_with_claymore!

ayaka = Non_Standard.new("Kamisato Ayaka")
ayaka.alt_sprint_stealthily!       
ayaka.walk_calmly! 
ayaka.pummel_with_sprint_attack!

puts "Diluc sprint mode: #{diluc.sprint_mode}"
puts "Ayaka strike mode: #{ayaka.pummel_mode}"

puts "Full state of both objects:"
p diluc
p ayaka
