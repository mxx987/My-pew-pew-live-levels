computed_vertexes = {}
computed_segments = {}
computed_colors = {}

local width = 800
local height = 800

local z_start = 0
local z_end = 400
local z_step = 50

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3

for z = z_start, z_end, z_step do
  table.insert(computed_vertexes, {0,0,z})
  table.insert(computed_vertexes, {width,0,z})
  table.insert(computed_vertexes, {width,height,z})
  table.insert(computed_vertexes, {0,height,z})
  
  table.insert(computed_segments, {index1, index2, index3, index4, index1})
  
  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4

  local alpha = math.floor(255 * (z_end - z) / (z_end - z_start))
  
  local color = 0xffffff00 + alpha
  table.insert(computed_colors, color)
  
  table.insert(computed_colors, color)
  table.insert(computed_colors, color)
  table.insert(computed_colors, color)
end
meshes = {
  {
    vertexes = computed_vertexes,
    segments = computed_segments,
    colors = computed_colors
  }
}