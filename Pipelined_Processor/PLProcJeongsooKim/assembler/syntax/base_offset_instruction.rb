class BaseOffsetInstructionSyntax < Syntax
  parse %r{^\s*(?<mnemonic>[a-z]+)
            \s+(?<dr>[a-z0-9]{2})
            \s*,\s*(?:(?<hex>0x[0-9a-f]+)|(?<decimal>-?\d+)|(?<symbol>\w+))
            \((?<baser>[a-z0-9]{2})\)(?!\S+)
           }ix do |match|

    @mnemonic = match[:mnemonic].upcase
    @dr = match[:dr].downcase.intern
    @baser = match[:baser].downcase.intern

    if match[:hex]
      @immval = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @immval = match[:decimal].to_i(10) # decimal constant
    elsif match[:symbol]
      @immval = match[:symbol].downcase.intern # symbol value
    end

    case @mnemonic
    when "LW"
      @instruction = :load
    when "SW"
      @instruction = :store
    when "JAL"
      @instruction = :jal
    else
      next                      # no match due to unrecognized opcode
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :instr, 4, align: 4
  end

  generate :instr do |bits, addr|
    if @immval.is_a? Symbol
      @immval = symbol_table[@immval].value_or_word & 0xFFFF
    end
    instr = instruction(@instruction).new(@dr, @baser, @immval)
    bits[0..31] = instr.to_bits
  end
end
