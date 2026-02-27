function make_mesh()
  local vertexes = {}
  local segments = {}
  local colors = {}

  local function add_cube(x, y, size, color)
    local start_idx = #vertexes
    table.insert(vertexes, {x - size, y - size})
    table.insert(vertexes, {x + size, y - size})
    table.insert(vertexes, {x + size, y + size})
    table.insert(vertexes, {x - size, y + size})
    
    table.insert(segments, {start_idx, start_idx + 1, start_idx + 2, start_idx + 3, start_idx})
    for i=1,4 do table.insert(colors, color) end
  end

  local spacing = 100
  local size = 50

  local layer_colors = {
    0xffffffff,
    0xffffff80,
    0xffffff40,
    0xffffff15
  }
  
  for layer = 1, #layer_colors do
    local offset = (layer - 1) * 100
    local current_color = layer_colors[layer]
    local pos = 500 + offset
    for i = -500, 500, spacing do
      add_cube(i, -pos, size, current_color)
      add_cube(i, pos, size, current_color)
      add_cube(-pos, i, size, current_color)
      add_cube(pos, i, size, current_color)
    end
    
    add_cube(-pos, -pos, size, current_color)
    add_cube(pos, -pos, size, current_color)
    add_cube(-pos, pos, size, current_color)
    add_cube(pos, pos, size, current_color)
  end

  return {vertexes = vertexes, segments = segments, colors = colors}
end

meshes = { make_mesh() }