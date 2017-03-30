class NotPseudoSyntax < Syntax
  parse %r{^\s*NOT\s+(?<rx>[a-z0-9]{2})\s*,\s*(?<ry>[a-z0-9]{2})(?!\S+)}ix do |match|
    @rx = match[:rx].downcase.intern
    @ry = match[:ry].downcase.intern

    # Return true to confirm the match
    true
  end

  preprocess do
    reserve_region :nand_instr, 4, align: 4
  end

  generate :nand_instr do |bits, addr|
    instr = instruction(:alu_r).new(:nand,  @rx, @ry, @ry)
    bits[0..31] = instr.to_bits
  end
end
