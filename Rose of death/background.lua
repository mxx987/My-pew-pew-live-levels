local spacing = 10
local size = 5
local v, s, c = {}, {}, {}
local sides = 6

for i = -5, 5 do
    for j = -5, 5 do
        local ox = i * spacing
        local oy = j * spacing

        local base = #v
        for k = 0, sides - 1 do
            local angle = k * (math.pi * 2 / sides)

            table.insert(v, {ox + size * math.cos(angle), oy + size * math.sin(angle), 0fx})
            table.insert(c, 0x333333ff)
        end

        for k = 0, sides - 1 do
            local current = base + k
            local next_v = base + (k + 1) % sides
            table.insert(s, {current, next_v})
        end
    end
end

meshes = {{vertexes = v, segments = s, colors = c}}