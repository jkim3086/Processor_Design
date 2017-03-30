class StoreInstruction < Instruction
  # List fields in order they should be passed to constructor
  # syntax: [range], [type], [name]
  field 20..23, :register, :dr
  field 16..19, :register, :sr1
  field 0..15, :offset, :immval

  # For fields that always have the same value, specify a default value
  # using the syntax :name => value
  field 28..31, :opcode, :opcode => :sw
  pad 24..27                    # no function number
end
