class CmpIField < EnumField
  width 4
  value :ti, 0b0000
  value :fi, 0b0011
  value :nei, 0b0101
  value :eqi, 0b0110
  value :lti, 0b1001
  value :gtei, 0b1010
  value :ltei, 0b1100
  value :gti, 0b1111
end
