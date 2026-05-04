computed_vertexes = {}
computed_segments = {}
computed_colors = {}

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3


for i=1, 100 do
  local x = math.random(0, 200)
  local y = math.random(0, 100)
  local size = 4

  table.insert(computed_vertexes, {x, y + size, 0})
  table.insert(computed_vertexes, {x + size, y, 0}) 
  table.insert(computed_vertexes, {x, y - size, 0}) 
  table.insert(computed_vertexes, {x - size, y, 0})


  table.insert(computed_segments, {index1, index2, index3, index4, index1})
  
  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4


  for c=1, 4 do
    table.insert(computed_colors, 0xffffffff)
  end
end

meshes = {
  {
    vertexes = computed_vertexes,
    segments = computed_segments,
    colors = computed_colors
  }
}
