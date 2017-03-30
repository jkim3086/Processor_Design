class RegisterField < EnumField
  width 4
  value [:r0,:a0], 0b0000
  value [:r1,:a1], 0b0001
  value [:r2,:a2], 0b0010
  value [:r3,:a3, :rv], 0b0011
  value [:r4,:t0], 0b0100
  value [:r5,:t1], 0b0101
  value [:r6,:s0], 0b0110
  value [:r7,:s1], 0b0111
  value [:r8,:s2], 0b1000
  value :r9, 0b1001
  value :r10, 0b1010
  value :r11, 0b1011
  value [:r12,:gp], 0b1100
  value [:r13,:fp], 0b1101
  value [:r14,:sp], 0b1110
  value [:r15,:ra], 0b1111
end
