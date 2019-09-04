module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_reader :attributes

    def validate(*args)
      @attributes ||= []
      @attributes << args
    end
  end

  module InstanceMethods
    def presence(value)
      raise 'Значение nil или пустая строка!' if value.to_s.empty?
    end

    def format(value, expectation)
      raise 'Значение не соответствует выражению!' if value !~ expectation
    end

    def type(value, type)
      raise 'Не совпадает класс!!!' unless value.is_a? type
    end

    def validate!
      temp = self.class.attributes
      temp.each do |value|
        if value[1] == :presence
          send(value[1], instance_variable_get("@#{value[0]}"))
        else
          send(value[1], instance_variable_get("@#{value[0]}"), value[2])
        end
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end
  end
end
