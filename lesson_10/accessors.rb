# Accesor class, keep recording datas for named variables
module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      puts "Вошло имя #{name}"
      #Guard clause
      raise 'значение не символ' unless name.is_a? Symbol
      puts "#{name} прошло проверку :"
      #getter for instance variable
      attr_reader name
      puts "#{name} сработал геттер"
      history = "@#{name}_history"
      #setter method for instance variable + setup history method
      define_method("#{name}=") do |v|
        if instance_variable_defined?(history)
          array = instance_variable_get(history)
        else
          array = []
        end
        instance_variable_set(name, v)
        instance_variable_set(history, array << v )
      end
      define_method(history) { instance_variable_get(history) }
    end
  end

  def strong_attr_accessor(name, type)
    raise 'Не совпадает класс!!!' unless name.is_a?(type)
    getter(name)
    define_method("#{name}=") do |v|
      instance_variable_set("@#{name}", v)
    end
  end
end

class Test
  extend Accessors
  attr_accessor_with_history :smth, :smthelse, :smthmore
end

 test = Test.new
 test.smth = 1
 test.smth = 3
 test.smth = 5
 test.smthelse = 2
 test.smthmore = 3

 puts test.smth_history
