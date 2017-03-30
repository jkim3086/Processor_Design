class Context
  def initialize
    @bytes = []
    @symbol_table = {}
    @symbol_stack = []
    @hint_table = {}
    @hint_stack = []
    @cursor = 0

    # Override array accessor to initialize bytes to zero
    @bytes.instance_eval do
      def [](index)
        self.at(index) ? self.at(index) : 0
      end
    end
  end

  attr_reader :bytes
  attr_reader :cursor
  attr_reader :symbol_table
  attr_reader :hint_table

  def seek(bytes)
    @cursor += bytes
  end

  def seek_to(address)
    @cursor = address
  end

  def get_region(size, options_or_nil = nil)
    # Process any options
    if options_or_nil.is_a? Hash
      # if requested, align the cursor
      align(options_or_nil[:align]) if options_or_nil.has_key? :align
    end

    # Pop any symbols and hints
    pop_symbols()
    pop_hints()
    # Create a new region at the cursor of 'size' bytes
    region = Region.new(@bytes, @cursor, size)
    seek(size)                  # seek out over the new region

    return region
  end

  def align(factor)
    if @cursor % factor != 0
      @cursor = @cursor + factor - (@cursor % factor)
    else
      @cursor
    end
  end

  def push_symbol(name)
    @symbol_stack.push(name)
  end

  def pop_symbols
    until @symbol_stack.empty?
      @symbol_table[@symbol_stack.pop] = SymbolEntry.new(@cursor, :label)
    end
  end

  def push_hint(hint)
    @hint_stack.push(hint)
  end

  def pop_hints
    until @hint_stack.empty?
      @hint_table[@cursor] = @hint_stack.pop
    end
  end
end
