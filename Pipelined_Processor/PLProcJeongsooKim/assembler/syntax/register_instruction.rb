class RegisterInstructionSyntax < Syntax
  parse %r{^\s*(?<mnemonic>[a-z]+)
            \s+(?<rx>[a-z0-9]{2})
            \s*,\s*(?<ry>[a-z0-9]{2})
            \s*,\s*(?<rz>[a-z0-9]{2})(?!\S+)
          }ix do |match|

    @mnemonic = match[:mnemonic].upcase
    @rx = match[:rx].downcase.intern
    @ry = match[:ry].downcase.intern
    @rz = match[:rz].downcase.intern

    case @mnemonic
    when "ADD", "SUB", "AND", "OR", "XOR", "NAND", "NOR", "XNOR"
      @instruction = :alu_r
      @func = @mnemonic.downcase.intern
    when "F", "EQ", "LT", "LTE", "T", "NE", "GTE", "GT"
      @instruction = :cmp_r
      @func = @mnemonic.downcase.intern
    else
      next                 # no match b/c invalid opcode for this type
    end

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :instr, 4, align: 4
  end

  generate :instr do |bits, addr|
    instr = instruction(@instruction).new(@func, @rx, @ry, @rz)
    bits[0..31] = instr.to_bits
  end
end
