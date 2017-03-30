class BranchInstruction < Instruction
  # List fields in order they should be passed to constructor
  # syntax: [range], [type], [name]
  field 24..27, :branch, :func
  field 20..23, :register, :dr
  field 16..19, :register, :sr1 => nil
  field 0..15, :offset, :immval
  
  # For fields that always have the same value, specify a default value
  # using the syntax :name => value
  field 28..31, :opcode, :opcode => :branch
end
