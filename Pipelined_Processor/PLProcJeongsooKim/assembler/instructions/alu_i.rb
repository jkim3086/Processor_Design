class AluIInstruction < Instruction
  # List fields in order they should be passed to constructor
  # syntax: [range], [type], [name]
  field 24..27, :alu_i, :func
  field 20..23, :register, :dr
  field 16..19, :register, :sr1 => nil # allow empty
  field 0..15, :offset, :immval

  # For fields that always have the same value, specify a default value
  # using the syntax :name => value
  field 28..31, :opcode, :opcode => :alu_i
end
