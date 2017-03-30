class WordSyntax < Syntax
  parse %r{^\s*.word\s+(?:(?<hex>0x[0-9a-f]+)|(?<decimal>\d+))(?!\S+)}ix do |match|
    if match[:hex]
      @value = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @value = match[:decimal].to_i(10) # decimal constant
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :data, 4, align: 4
  end

  generate :data do |bits, addr|
    bits[0..31] = @value
  end
end
