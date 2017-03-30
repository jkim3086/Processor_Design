class OrigSyntax < Syntax
  parse %r{^\s*.orig\s+(?:(?<hex>0x[0-9a-f]+)|(?<decimal>\d+))(?!\S+)}ix do |match|
    if match[:hex]
      @address = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @address = match[:decimal].to_i(10) # decimal constant
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    seek_to @address
  end
end
