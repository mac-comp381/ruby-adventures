## uses metaprogramming and ruby's method_missing function to create an ice cream cone with a pile of scoops. Can also print out a visual of the ice cream cone
class IceCreamCone
    def initialize(cone:, scoops: [])
      @cone = cone
      @scoops = scoops
    end

    def method_missing(name, *args)  
        IceCreamCone.new(
            cone: @cone,
            scoops: @scoops << name.to_s
        ) 
    end

    def to_s
        scoops_to_s + cone_to_s
    end

    def scoops_to_s
        str = ""
        @scoops.reverse.each do |flavor|
            flavor.each_char do |character|
                str += "_"
            end
            str += "__\n"
            str += "|#{flavor}|\n"
            flavor.each_char do 
                str += "-"
            end
            str += "--\n"
        end
        str
    end

    def cone_to_s
        str = ""
        cone_string = "#{@cone} cone"
        str += "\\#{cone_string}/\n"

        string_length = cone_string.length 
        count = 1
        (string_length / 2).times do
            (count).times do 
                str += " "
            end
            str += "\\"
            (string_length - count * 2).times do 
                str += " "
            end
            str += "/\n"
            count += 1
        end
        str
    end
end



lucy_cone = IceCreamCone.new(cone: :sugar)
fred_cone = IceCreamCone.new(cone: :waffle)

puts <<_EOS_
Lucy\'s ice cream cone:
#{lucy_cone.vanilla.chocolate.chocolate.vanilla.pineapple}

Fred\'s ice cream cone:
#{fred_cone.blueberry.bubblegum}
_EOS_

  
  
  
  