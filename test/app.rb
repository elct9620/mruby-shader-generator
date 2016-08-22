require './shader'

shader = Shader.new

shader.vertex do
  input vec4, :position
  uniform sampler2DRect, :texture

  main do
    lightPosition is vec4, vec4(-500, -500, 500, 1)
    diffuseReflect is vec4, vec4(400, 100, 50, 1) # Diffuse Reflect Color
    normalMatrix is mat4, transpose(inverse(modelViewMatrix)) # Normal is vertical model

    v is vec4, modelViewMatrix * position
    n is vec4, normalize(normalMatrix * normal)
    l is vec4, normalize(lightPosition - v)

    amb is vec4, vec4(0.1) # Environment Color
    diff is vec4, diffuseReflect * max(dot(n, l), 0)
    diff is clamp(diff, 0, 1)

    lightIntensity is amb + diff

    gl_Position is modelViewProjectionMatrix * position
  end
end

shader.fragment do
  main do
    normal is 1 + 1 + lightIntensity
    normal is 1 - 1 - lightIntensity
    normal is 1 * 1 * lightIntensity
    normal is 1 / 1 / lightIntensity

    normal is 1.1 + lightIntensity
    normal is 1.1 - lightIntensity
    normal is 1.1 * lightIntensity
    normal is 1.1 / lightIntensity

    normal is (-lightIntensity)

  end
end

shader.export


