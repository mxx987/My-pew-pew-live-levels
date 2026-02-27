local spacing = 2
local size = 0.1
local v, s, c = {}, {}, {}

for i = -15, 15 do
    local ox = i * spacing
    for j = -15, 15 do
        local oy = j * spacing
        local base = #v
        table.insert(v, {ox - size, oy - size, 0fx})
        table.insert(v, {ox + size, oy - size, 0fx})
        table.insert(v, {ox + size, oy + size, 0fx})
        table.insert(v, {ox - size, oy + size, 0fx})

        for k = 1, 4 do table.insert(c, 0x333333ff) end

        table.insert(s, {base, base + 1})
        table.insert(s, {base + 1, base + 2})
        table.insert(s, {base + 2, base + 3})
        table.insert(s, {base + 3, base})
    end
end

meshes = {{vertexes = v, segments = s, colors = c}}