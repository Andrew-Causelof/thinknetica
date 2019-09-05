module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods
  end

  module ClassMethods
    attr_reader :attributes

    def validate(name, type, *option)
      @attributes ||= []
      @attributes << { type: type, name: name, option: option }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise 'Значение nil или пустая строка!' if value.to_s.empty?
    end

    def validate_format(value, expectation)
      raise 'Значение не соответствует выражению!' if value !~ expectation
    end

    def validate_type(value, type)
      raise 'Не совпадает класс!!!' unless value.is_a? type
    end

    def validate!
      self.class.attributes.each do |value|
        send(value[:type], instance_variable_get("@#{value[:name]}"), *value[:option])
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
