class ImmediateInstructionSyntax < Syntax
  parse %r{^\s*(?<mnemonic>[a-z]+)
            \s+(?<rx>[a-z0-9]{2})
            (?:\s*,\s*(?<ry>[a-z0-9]{2}))?
 \s*,\s*(?:(?<hex>0x[0-9a-f]+)|(?<decimal>-?\d+)|(?<symbol>\w+))(?!\S+)
          }ix do |match|

    @mnemonic = match[:mnemonic].upcase
    @rx = match[:rx].downcase.intern
    @ry = match[:ry] ? match[:ry].downcase.intern : nil

    if match[:hex]
      @immval = match[:hex].to_i(16) # hex constant
    elsif match[:decimal]
      @immval = match[:decimal].to_i(10) # decimal constant
    elsif match[:symbol]
      @immval = match[:symbol].downcase.intern # symbol value
    end

    case @mnemonic
    when *%w{ADDI SUBI ANDI ORI XORI NANDI NORI XNORI}
      @instruction = :alu_i
      @func = @mnemonic.downcase.intern
    when "MVHI"
      @instruction = :alu_i
      @func = @mnemonic.downcase.intern
      @upper_bits = true
    when *%w{FI EQI LTI LTEI TI NEI GTEI GTI}
      @instruction = :cmp_i
      @func = @mnemonic.downcase.intern
    when *%w{BF BEQ BLT BLTE BEQZ BLTZ BLTEZ BT BNE BGTE BGT BNEZ BGTEZ BGTZ}
      @instruction = :branch
      @func = @mnemonic.downcase.intern
      @pc_relative = true
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
      if @pc_relative
        @immval = ((symbol_table[@immval].value_or_word << 2) - addr - 4) >> 2
      elsif @upper_bits
        @immval = (symbol_table[@immval].value_or_word >> 16) & 0xFFFF
      else
        @immval = symbol_table[@immval].value_or_word & 0xFFFF
      end
    end
    instr = instruction(@instruction).new(@func, @rx, @ry, @immval)
    bits[0..31] = instr.to_bits
  end
end
