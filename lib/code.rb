def Object.const_missing(name)
  return Shader::Type.new(name.downcase) if Shader::TYPES.keys.include?(name.downcase)
  super
end

class Shader::Code
  TYPES.each do |type, typename|
    define_method(type) { |*args| Type.new(type, *args) }
  end

  VARYING.each do |name, keyword|
    define_method(name) do |type, attribute|
      @header << "#{keyword} #{type.to_typename} #{attribute};"
    end
  end

  FUNCTIONS.each do |name|
    define_method(name) do |*args|
      FunctionCall.new(name, *args)
    end
  end

  def initialize
    @header = []
    @body = []
  end

  def is(*args)
    value = args
    value = args.first if args.first.is_a?(Array)
    AssignNode.new(*value)
  end

  def export(code)
    @header << code
  end

  def assign(name, assign)
    export assign.to(name)
  end

  def is_const?(name)
    ("A".."Z").include?(name.to_s[0])
  end

  def method_missing(name, *args, &block)
    value = args.first
    return assign(name, value) if value.is_a?(AssignNode)
    return [send(name.downcase), value] if is_const?(name)
    Variable.new(name)
  end

  def const_missing(name)
    puts "CONST MISSING"
    send(name.downcase) if TYPES.has_key?(name.downcase)
  end

  def main(&block)
    @body << Function.new(:void, :main, [], &block)
  end

  def to_s
    [
      "#version 150",
      @header.join("\n"),
      @body.join("\n")
    ].join("\n\n")
  end
end
