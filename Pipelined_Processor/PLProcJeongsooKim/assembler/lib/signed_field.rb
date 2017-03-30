class SignedField

  class << self
    attr_accessor :i_width
  end

  def self.width(width)
    self.i_width = width
  end

  def initialize(value)
    unless self.class.i_width
      raise "Field width must be specified"
    end

    @value = BitRange.new(value, self.class.i_width)
  end

  def to_bits
    @value
  end

  def to_s
    "#{self.class.name}: #{value.bits.to_s}"
  end
end
