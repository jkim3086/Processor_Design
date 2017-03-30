# Defines a syntactic grammar
class Syntax
  include Loader

  class << self
    attr_accessor :parse_regexp
    attr_accessor :parse_block
    attr_accessor :preprocess_block
    attr_accessor :generator_blocks

    # Initialize subclass variables
    def inherited(subclass)
      subclass.class_eval do
        @generator_blocks = {}
      end
    end

    def parse(regexp, &block)
      self.parse_regexp = regexp
      self.parse_block = block
    end

    def preprocess(&block)
      self.preprocess_block = block
    end

    def generate(region, &block)
      self.generator_blocks[region] = block
    end
  end

  def initialize(line)
    if self.class.parse_regexp
      match = self.class.parse_regexp.match(line, 0)
      @matches = !match.nil?
      return if !@matches
      @match = match.to_s
      @match_pos = match.begin(0)
    end

    if self.class.parse_block
      @matches = !instance_exec(match, &self.class.parse_block).nil?
      return if !@matches
    end
  end

  def matches?
    @matches
  end

  def match_start
    @match_pos
  end

  def has_regions?
    !@regions.empty?
  end

  def preprocess(context)
    raise "Cannot preprocess a non-matching syntax" unless @matches
    @context = context
    @regions = {}
    instance_eval(&self.class.preprocess_block) if self.class.preprocess_block
  end

  def generate
    raise "Cannot generate a non-matching syntax" unless @matches
    raise "Syntax must be pre-processed prior to calling generate" \
      unless @context

    @regions.each do |name, region|
      if self.class.generator_blocks[name]
        bits = region.to_bits
        instance_exec(bits, region.start, &self.class.generator_blocks[name])
        region.assign_bits(bits)
      end
    end
  end

  protected
  def reserve_region(name, bytes, options_or_nil)
    # Push hint string for first region
    if @regions.empty?
      hint = @match.gsub(/\s+/, " ").gsub(/\s*,\s*/, ",").strip.upcase
      @context.push_hint(hint)
    end
    @regions[name] = @context.get_region(bytes, options_or_nil)
  end

  def symbol_table
    @context.symbol_table
  end

  def push_symbol(name)
    @context.push_symbol(name)
  end

  def push_hint(hint)
    @context.push_hint(hint)
  end

  def seek_to(address)
    @context.seek_to(address)
  end
end
