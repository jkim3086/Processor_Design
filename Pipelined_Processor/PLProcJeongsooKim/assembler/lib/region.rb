# Represents a region of memory
# and provides utilities for reading/writing BitRanges
class Region
  def initialize(bytes, start, size)
    @bytes = bytes
    @start = start
    @size = size
  end

  attr_reader :start
  attr_reader :size

  def assign_bits(bits)
    (0...@size).each do |i|
      start_bit = i * 8
      end_bit = ((i + 1) * 8) - 1
      byte = @start + i
      @bytes[byte] = bits[start_bit..end_bit].to_i
    end
  end

  def to_bits
    bits = BitRange.new(0, @size * 8)
    (0...@size).each do |i|
      start_bit = i * 8
      end_bit = ((i + 1) * 8) - 1
      byte = @start + i
      bits[start_bit..end_bit] = @bytes[byte]
    end
    return bits
  end
end
