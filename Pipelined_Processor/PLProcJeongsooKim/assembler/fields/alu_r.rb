class AluRField < EnumField
  width 4
  value :and, 0b0000
  value :or, 0b0001
  value :xor, 0b0010
  value :sub, 0b0110
  value :add, 0b0111
  value :nand, 0b1000
  value :nor, 0b1001
  value :xnor, 0b1010
end
