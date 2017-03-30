class CmpRField < EnumField
  width 4
  value :t, 0b0000
  value :f, 0b0011
  value :ne, 0b0101
  value :eq, 0b0110
  value :lt, 0b1001
  value :gte, 0b1010
  value :lte, 0b1100
  value :gt, 0b1111
end
