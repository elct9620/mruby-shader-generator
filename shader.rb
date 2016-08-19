# Default Class
class Shader
end

require './lib/code'

# DSL
class Shader
  def initialize
    @vertex = nil
    @fragment = nil
  end

  def vertex(&block)
    code = Code.new
    code.instance_eval(&block)
    @vertex = code
  end

  def fragment(&block)
    code = Code.new
    code.instance_eval(&block)
    @fragment = code
  end

  def export
    puts "Vertex Shader =====>"
    puts @vertex

    puts "Fragment Shader =====>"
    puts @fragment
  end
end
