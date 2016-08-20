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
    AssignNode.new(*args)
  end

  def export(code)
    @header << code
  end

  def assign(name, assign)
    export assign.to(name)
  end

  def method_missing(name, *args, &block)
    value = args.first
    return assign(name, value) if value.is_a?(AssignNode)
    Variable.new(name)
  end

  def main(&block)
    @body << Function.new(:void, :main, [], &block)
  end

  def to_s
    [
      @header.join("\n"),
      @body.join("\n")
    ].join("\n")
  end
end
