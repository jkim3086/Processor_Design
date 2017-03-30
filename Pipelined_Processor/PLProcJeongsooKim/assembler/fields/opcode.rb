class OpcodeField < EnumField
  width 4
  value :alu_r, 0b1100
  value :alu_i, 0b0100
  value :lw, 0b0111
  value :sw, 0b0011
  value :cmp_r, 0b1101
  value :cmp_i, 0b0101
  value :branch, 0b0010
  value :jal, 0b0110
end
