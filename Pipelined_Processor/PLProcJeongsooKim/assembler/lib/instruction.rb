class Instruction
  include Loader

  class << self
    attr_accessor :width
    attr_accessor :fields
    attr_accessor :fields_order

    def inherited(subclass)
      subclass.class_eval do
        @width = 0
        @fields = {}
        @fields_order = []
      end
    end

    def field(range, type, name_value)
      # Break out the name and default value
      field = {class: Loader.field(type), range: range}
      if name_value.is_a? Hash
        name = name_value.keys.first
        field[:default] = name_value.values.first
      else
        name = name_value
      end

      # Store the field
      self.fields[name] = field
      self.fields_order << name
      pad(range)
    end

    def pad(range)
      ## Expand the width as necessary
      if range.max > self.width - 1
        self.width = range.max + 1
      end
    end
  end


  def initialize(*args)
    @bits = BitRange.new(0, self.class.width)
    field_values = {}

    args.each_index do |i|
      arg = args[i]
      if arg.is_a? Hash
        arg.each do |key, value|
          field_values[key] = value
        end
      else
        field_name = self.class.fields_order[i]
        field_values[field_name] = arg
      end
    end

    self.class.fields.each do |name, field|
      raise "No value provided for required field #{name}" if \
        field_values[name].nil? && !field.has_key?(:default)

      value = field_values[name] || field[:default]

      if value
        field_bits = field[:class].new(value).to_bits
        @bits[field[:range]] = field_bits
      end
    end
  end

  def to_bits
    @bits
  end
end
