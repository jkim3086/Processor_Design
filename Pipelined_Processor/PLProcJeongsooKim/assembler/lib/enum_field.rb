class EnumField
  class << self
    attr_writer :width
    attr_accessor :value_map

    def inherited(subclass)
      subclass.class_eval do
        @width = 0
        @value_map = {}
      end
    end

    def width(width = nil)
      @width = width if width
      @width
    end

    def value(key, value)
      # Normalize the value
      if value.is_a? Integer
        # Convert the integer to a BitRange using specified width
        raise "Width must be defined before specifying integer constants" \
          unless self.width

        value = BitRange.new(value, self.width)
      elsif value.is_a? BitRange
        # Validate bit width if specified
        if self.i_width
          if value.size < self.i_width
            value = BitRange.new(value, self.width)
          elsif value.size > self.width
            raise "Constant does not fit in field width"
          end
        end
      else
        raise "Unrecognized constant type"
      end

      # Assign the key, or each item of array keys
      if key.is_a? Array
        key.each do |k|
          self.value_map[k] = value
        end
      else
        self.value_map[key] = value
      end
    end
  end

  def initialize(value)
    if self.class.value_map.has_key? value
      @key = value
    else
      raise "Unrecognized field value: #{value}"
    end
  end

  def to_bits
    self.class.value_map[@key]
  end

  def to_s
    "#{self.class.name}: #{@key_name}"
  end
end
