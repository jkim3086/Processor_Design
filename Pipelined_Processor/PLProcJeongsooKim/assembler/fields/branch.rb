class BranchField < EnumField
  width 4
  value :bt, 0b0000
  value :bnez, 0b0001
  value :beqz, 0b0010
  value :bf, 0b0011
  value :bne, 0b0101
  value :beq, 0b0110
  value :bltez, 0b1000
  value :blt, 0b1001
  value :bgte, 0b1010
  value :bgt, 0b1011
  value :blte, 0b1100
  value :bltz, 0b1101
  value :bgtez, 0b1110
  value :bgtz, 0b1111
  value :jal, 0b0000
end
