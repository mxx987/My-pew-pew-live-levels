local size = 8
local spacing = (size * 2)
v, s, c = {}, {}, {}
for i = -10, 10 do
    local ox = i * spacing
    for j = -10, 10 do
        local oy = j * spacing
        local base = #v
        table.insert(v, {ox - size, oy - size, 0fx})
        table.insert(v, {ox + size, oy + size, 0fx})
        table.insert(v, {ox + size, oy - size, 0fx})
        table.insert(v, {ox - size, oy + size, 0fx})
        for k = 1, 4 do table.insert(c, 0x333333ff) end
        table.insert(s, {base, base + 1})
        table.insert(s, {base + 2, base + 3})
    end
end
meshes = {{vertexes = v, segments = s, colors = c}}