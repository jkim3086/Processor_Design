module Loader
  def field(name)
    resolve_entity(name, "Field", "fields")
  end

  def instruction(name)
    resolve_entity(name, "Instruction", "instructions")
  end

  def syntax(name)
    resolve_entity(name, "Syntax", "syntax")
  end

  def resolve_entity(name, suffix, dirname)
    # Form the class name by camel-casing and appending the suffix
    class_name = name.to_s.split('_').collect(&:capitalize).join + suffix

    # Load the entity if not defined already
    unless Object.const_defined? class_name
      begin
        require "#{dirname}/#{name}"
      rescue LoadError
        return nil
      end
    end

    return Object.const_get(class_name)
  end
end
