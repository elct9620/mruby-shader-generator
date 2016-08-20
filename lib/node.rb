module Shader::Calculable
  def operation
    @operation ||= []
  end

  def +(other)
    operation.push("+", other)
    self
  end

  def -(other)
    operation.push("-", other)
    self
  end

  def *(other)
    operation.push("*", other)
    self
  end

  def /(other)
    operation.push("/", other)
    self
  end

  def to_expression
    return to_s if operation.empty?
    "#{to_s} #{operation.join(" ")}"
  end
end

class Shader::AssignNode
  def initialize(type, *args)
    @type = type
    @expression = args.shift

    unless type.is_a?(Type) && !@expression.nil?
      @expression = @type
      @type = nil
    end
  end

  def expression
    return @expression.to_expression if @expression.respond_to?(:to_expression)
    @expression
  end

  def to(name)
    return "#{name} = #{expression};" if @type.nil?
    "#{@type.to_typename} #{name} = #{expression};"
  end

  def to_s
    to(nil)
  end
end

class Shader::ExpressionNode
  include Calculable
end
