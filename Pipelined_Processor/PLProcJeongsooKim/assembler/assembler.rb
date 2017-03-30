require './lib/init'
include Loader

asm_filename = ARGV[0]
mif_filename = ARGV[1]

# Load all syntaxes into an array
syntaxes = []
Dir.glob "./syntax/*.rb" do |filename|
  syntax_name = File.basename(filename, ".rb").intern
  syntaxes << Loader.syntax(syntax_name)
end

# Create an assembler context
context = Context.new
second_pass = []

# Read our assembly file
File.open(asm_filename, "r") do |f|
  line_number = 0
  # Parse line-by-line
  f.each_line do |line|
    # Increment line number
    line_number += 1

    # Attempt to match against each syntax
    parsed = syntaxes.map { |s| s.new(line) }
    matches = parsed.select { |s| s.matches? }

    # If the line doesn't match any syntax AND is not empty, error
    if matches.empty? && !line.match(/^\s*$/)
      raise "Cannot parse line [#{line_number}]: #{line}"
    end

    # Pre-process matches on the line in order of appearance
    ordered_matches = matches.sort { |a, b| a.match_start <=> b.match_start }
    ordered_matches.each do |s|
      s.preprocess(context)
      second_pass << s if s.has_regions?
    end
  end
end

# Perform a second pass, generating all instructions
second_pass.each do |s|
  begin
    s.generate
  rescue => e
    puts s
    raise e
  end
end

# Begin writing the MIF file
File.open(mif_filename, "w") do |f|
  # Print the MIF header
  f.puts "WIDTH=32;"
  f.puts "DEPTH=2048;"
  f.puts "ADDRESS_RADIX=HEX;"
  f.puts "DATA_RADIX=HEX;"
  f.puts "CONTENT BEGIN"

  # Iterate over our array by words
  address = 0x0
  dead_start = 0x0
  dead_bytes = 0
  bytes = context.bytes
  while address < 8189
    word = Region.new(bytes, address, 4)
    hint = context.hint_table[address]

    # Generate the data line
    word_address = address >> 2
    inst_bits = word.to_bits.to_i

    if inst_bits == 0
      # Start a new sequence of dead words
      if dead_bytes == 0
        dead_start = address
      end
      dead_bytes += 4
    else
      if dead_bytes > 0
        # Terminate the last sequence of dead words
        first_dead_word = dead_start >> 2
        last_dead_word = (dead_start + dead_bytes - 1) >> 2
        if first_dead_word != last_dead_word
          address_str = "[#{"%08x" % first_dead_word}..#{"%08x" % last_dead_word}]"
        else
          address_str = "#{"%08x" % first_dead_word}"
        end
        f.puts "#{address_str} : DEAD;"

        # Reset the dead words counter
        dead_bytes = 0
      end

      # Generate a comment line if we have a hint
      f.puts "-- @ #{"0x%08x" % address} : #{hint}" if hint

      # Output the single word
      f.puts "#{"%08x" % word_address} : #{"%08x" % inst_bits};"
    end

    # Move to the next word
    address += 4
  end

  # Wrap up any remaining sequence of dead words
  if dead_bytes > 0
    # Terminate the last sequence of dead words
    first_dead_word = dead_start >> 2
    last_dead_word = (dead_start + dead_bytes - 1) >> 2
    f.puts "[#{"%08x" % first_dead_word}..#{"%08x" % last_dead_word}] : DEAD;"
  end

  # Close out the file
  f.puts "END;"
end

File.open("#{mif_filename}.mem", "w") do |f|
  f.puts "// memory data file (do not edit the following line - required for mem load use)"
  f.puts "// format=mti addressradix=h dataradix=h version=1.0 wordsperline=1"

  address = 0x0
  while address < 8189
    word = Region.new(context.bytes, address, 4)
    word_address = address >> 2
    inst_bits = word.to_bits.to_i

    f.puts "#{"%x" % word_address}: #{"%08x" % inst_bits}"

    address += 4
  end

end
