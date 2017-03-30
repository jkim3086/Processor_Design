class SymbolEntry
  def initialize(value, type)
    @value = value
    @type = type
  end

  attr_accessor :value
  attr_accessor :type

  def value_or_word
    case @type
    when :label
      @value >> 2
    when :const
      @value
    end
  end
end
