class CommentSyntax < Syntax
  parse %r{!|;(.*)}
end
