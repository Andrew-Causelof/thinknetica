# Accesor class, keep recording datas for named variables
module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      # Guard clause
      raise 'значение не символ' unless name.is_a? Symbol

      # Setter for instance variable
      attr_reader name, "#{name}_history"
      # Setter method for instance variable + setup history method
      define_method("#{name}=") do |v|
        if instance_variable_defined?("@#{name}_history")
          array = instance_variable_get("@#{name}_history")
          array << instance_variable_get("@#{name}")
        else
          instance_variable_set("@#{name}_history", [])
        end
        instance_variable_set("@#{name}", v)
      end
    end
  end

  def strong_attr_accessor(name, type)
    raise 'значение не символ' unless name.is_a? Symbol

    attr_reader name
    define_method("#{name}=") do |v|
      raise 'Не совпадает класс!!!' unless v.is_a?(type)

      instance_variable_set("@#{name}", v)
    end
  end
end

 class Test
   extend Accessors
   attr_accessor_with_history :smth, :smthelse, :smthmore
   strong_attr_accessor :first, String
    @frist = String.new
 end
 test = Test.new
 test.smth = 1
 test.smth = 3
 test.smth = 5
 test.smthelse = 2
 test.smthmore = 3
# puts test.smth
 puts test.smth_history
 test.first = 'lets try it out'
 puts test.first
