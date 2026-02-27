--3
function f1(angle)
  return 100 * math.abs(math.cos(3 * angle)) 
end

--8
function f2(angle)
  return 150 * math.sin(4 * angle)
end

function mesh_from_polar_function(f)
  computed_vertexes = {}

  local index = 0
  local line = {}
  for angle = 0, math.pi * 2, 0.05 do
    local radius = f(angle)
    local x = math.cos(angle) * radius
    local y = math.sin(angle) * radius
    table.insert(computed_vertexes, {x, y})
    table.insert(line, index)
    index = index + 1
  end
  table.insert(line, 0)

  return  {
    vertexes = computed_vertexes,
    segments = {line},
  }
end



meshes = {
  mesh_from_polar_function(f1),
  mesh_from_polar_function(f2),
}