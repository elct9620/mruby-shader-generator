# Default Class
class Shader
  TYPES = {
    vec2: "vec2",
    vec3: "vec3",
    vec4: "vec4",
    mat3: "mat3",
    mat4: "mat4",
    float: "float",
    sampler2d: "sampler2D",
    sampler2DRect: "sampler2DRect"
  }

  TYPE_VALUES = {
    # Special Type should provide special convert feature
    float: -> (*args) { args.first }
  }

  VARYING = {
    input: "in",
    output: "out",
    uniform: "uniform",
    varying: "varying"
  }

  FUNCTIONS = %w{
    transpose
    inverse
    normalize
    max
    dot
    reflect
    refract
    pow
    clamp
    mix
    texture
  }
end

require './lib/node'
require './lib/type'
require './lib/code'
require './lib/function'

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
