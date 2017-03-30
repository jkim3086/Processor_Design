class NameSyntax < Syntax
  parse %r{^\s*.name\s+(?<name>[a-z]+)
            \s*=\s*(?:(?<hex>0x[0-9a-f]+)|(?<decimal>-?\d+))(?!\S+)}ix do |match|
    @label = match[:name].downcase.intern
    if match[:hex]
      @value = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @value = match[:decimal].to_i(10) # decimal constant
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    symbol_table[@label] = SymbolEntry.new(@value, :const)
  end
end
