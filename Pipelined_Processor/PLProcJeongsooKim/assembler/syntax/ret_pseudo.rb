class RetPseudoSyntax < Syntax
  parse %r{^\s*RET(?!\S+)}ix

  preprocess do
    reserve_region :jal_instr, 4, align: 4
  end

  generate :jal_instr do |bits, addr|
    instr = instruction(:jal).new(:r9, :ra, 0)
    bits[0..31] = instr.to_bits
  end
end
