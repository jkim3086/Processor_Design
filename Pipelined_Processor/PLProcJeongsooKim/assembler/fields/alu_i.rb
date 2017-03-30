class AluIField < EnumField
  width 4
  value :andi, 0b0000
  value :ori, 0b0001
  value :xori, 0b0010
  value :subi, 0b0110
  value :addi, 0b0111
  value :nandi, 0b1000
  value :nori, 0b1001
  value :xnori, 0b1010
  value :mvhi, 0b1111
end
