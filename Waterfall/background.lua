local spacing = 8
local size = 4
local v, s, c = {}, {}, {}

for i = -10, 10 do
    local ox = i * spacing
    for j = -10, 10 do
        local oy = j * spacing
        local base = #v
        table.insert(v, {ox - size, oy - size, 0fx})
        table.insert(v, {ox + size, oy - size, 0fx})
        table.insert(v, {ox + size, oy + size, 0fx})
        table.insert(v, {ox - size, oy + size, 0fx})

        for k = 1, 4 do table.insert(c, 0x0000ffa1) end

        table.insert(s, {base, base + 1})
        table.insert(s, {base + 1, base + 2})
        table.insert(s, {base + 2, base + 3})
        table.insert(s, {base + 3, base})
    end
end

-- waterfall
local wf_base = #v
local wf_width = 40
local wf_height = 120

for i = -2, 2 do
    local x_offset = i * 4
    local current_base = #v
    table.insert(v, {x_offset, -wf_height/2, 0fx})
    table.insert(v, {x_offset, wf_height/2, 0fx})
    table.insert(c, 0x00ffffff)
    table.insert(c, 0x00ffffff)
    table.insert(s, {current_base, current_base + 1})
end

meshes = {{vertexes = v, segments = s, colors = c}}