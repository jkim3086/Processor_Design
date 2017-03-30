class CmpRInstruction < Instruction
  # List fields in order they should be passed to constructor
  # syntax: [range], [type], [name]
  field 24..27, :cmp_r, :func
  field 20..23, :register, :ds
  field 16..19, :register, :sr1
  field 12..15, :register, :sr2
  pad 0..11
  
  # For fields that always have the same value, specify a default value
  # using the syntax :name => value
  field 28..31, :opcode, :opcode => :cmp_r
end
