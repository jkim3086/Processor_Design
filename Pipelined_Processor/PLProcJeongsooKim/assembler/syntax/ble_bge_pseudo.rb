class BleBgePseudoSyntax < Syntax
  parse %r{^\s*(?<mnemonic>[a-z]+)
            \s+(?<rx>[a-z0-9]{2})
            \s*,\s*(?<ry>[a-z0-9]{2})
            \s*,\s*(?:(?<hex>0x[0-9a-f]+)|(?<decimal>-?\d+)|(?<symbol>\w+))(?!\S+)
          }ix do |match|

    @mnemonic = match[:mnemonic].upcase
    @rx = match[:rx].downcase.intern
    @ry = match[:ry].downcase.intern

    if match[:hex]
      @immval = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @immval = match[:decimal].to_i(10) # decimal constant
    elsif match[:symbol]
      @immval = match[:symbol].downcase.intern # symbol value
    end

    case @mnemonic
    when "BLE"
      @cmpfunc = :lte
    when "BGE"
      @cmpfunc = :gte
    else
      next                      # no match due to unrecognized opcode
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :instr1, 4, align: 4
    reserve_region :instr2, 4, align: 4
  end

  generate :instr1 do |bits, addr|
    instr = instruction(:cmp_r).new(@cmpfunc, :r6, @rx, @ry)
    bits[0..31] = instr.to_bits
  end

  generate :instr2 do |bits, addr|
    if @immval.is_a? Symbol
      @immval = symbol_table[@immval] - addr - 4
    end
    instr = instruction(:branch).new(:bnez,:r6,nil,@immval)
  end
end
