# Accesor class, keep recording datas for named variables
module Accessors
  attr_reader :store_variable
  @store_variable ||= {}

  def attr_accessor_with_history(*args)
    puts @store_variable
    puts args.size
    sleep(1)
    args.each do |name|
      raise 'значение не символ' unless name.is_a? Symbol
      getter(name)
      define_method("#{name}=") do |v|
        setup_variable(name, v) if @store_variable[name] != v
        instance_variable_set("@#{name}", v)
      end
      #define_method("#{name}_history") do
      #  @store_variable[name]
      #end
    end
  end

  def strong_attr_accessor(name, type)
    raise 'Не совпадает класс!!!' unless name.is_a?(type)
    getter(name)
    define_method("#{name}=") do |v|
      instance_variable_set("@#{name}", v)
    end
  end

  private

  def getter(name)
    define_method(name) do
      instance_variable_get("@#{name}")
    end
  end

  def setup_variable(name, value)
    puts "выводим хэш #{@store_variable}"
    store = []
    store << @store_variable[name]
    store << value
    @store_variable[name] = store
  end
end
