class LabelSyntax < Syntax
  parse %r{^\s*(?<label>.+):} do |match|
    @label = match[:label].downcase.intern

    # Return true to confirm the match
    true
  end

  preprocess do
    push_symbol @label
  end
end
