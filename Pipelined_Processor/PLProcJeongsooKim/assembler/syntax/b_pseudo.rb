class BPseudoSyntax < Syntax
  parse %r{^\s*br\s+(?:(?<hex>0x[0-9a-f]+)|(?<decimal>-?\d+)|(?<symbol>(\w+))(?!\w*\s*,\s*))(?!\S+)}ix do |match|
    if match[:hex]
      @immval = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @immval = match[:decimal].to_i(10) # decimal constant
    elsif match[:symbol]
      @immval = match[:symbol].downcase.intern # symbol value
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :beq_instr, 4, align: 4
  end

  generate :beq_instr do |bits, addr|
    if @immval.is_a? Symbol
      @immval = symbol_table[@immval] - addr - 4
    end
    instr = instruction(:branch).new(:beq, :r6, :r6, @immval)
    bits[0..31] = instr.to_bits
  end
end
