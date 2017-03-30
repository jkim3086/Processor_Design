# Defines a fixed-width range of bits
class BitRange
  def initialize(bits, num_bits)
    @bits = bits & ~(-1 << num_bits)
    @num_bits = num_bits
  end

  # Access either a single bit or a range
  def [](bit)
    if bit.is_a? Range
      raise "Range must be in ascending order" if bit.begin > bit.end
      raise "Index out of bounds" if bit.max > @num_bits - 1 \
                                     || bit.min < 0
      BitRange.new((@bits >> bit.min) & ~(-1 << bit.size), bit.size)
    else
      raise "Index out of bounds" if bit > @num_bits - 1
      (@bits >> bit) & 0x1
    end
  end

  # Set either a single bit or a range
  def []=(bit, value)
    if value.is_a? BitRange
      value = value.bits
    end

    if bit.is_a? Range
      raise "Range must be in ascending order" if bit.begin > bit.end
      raise "Index out of bounds" if bit.max > @num_bits - 1 \
                                     || bit.min < 0
      mask = ~(-1 << bit.size)
      value &= mask
      @bits &= ~(mask << bit.min)
      @bits |= value << bit.min
    else
      raise "Index out of bounds" if bit > @num_bits - 1
      mask = 0x1
      value &= mask
      @bits &= ~(mask << bit)
      @bits |= value << bit
    end
  end

  def size
    @num_bits
  end

  def bits
    return @bits
  end

  def to_i
    return @bits
  end

  # Format the range of bits as a string
  def to_s
    binary_str = @bits.to_s(2)
    while binary_str.size < @num_bits
      binary_str = "0" + binary_str
    end
    return binary_str
  end
end
