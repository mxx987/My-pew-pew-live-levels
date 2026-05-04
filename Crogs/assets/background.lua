-- X pattern
local size = 2 -- the size of the X
local spacing = (size * 3) -- the space between every X
v, s, c = {}, {}, {}

for i = -4, 4 do -- the number of Xs on the (X) grid (from negative to positive)
    local ox = i * spacing -- setting up that position using the spacing
    for j = -3, 3 do -- same as the I but with the (y) grid between y level of - and positive
        local oy = j * spacing -- same as ox but with y
        local base = #v -- defines the base
        table.insert(v, {ox - size, oy - size, 0fx})  -- sets the first segment
        table.insert(v, {ox + size, oy + size, 0fx}) -- sets the second segment for the first line
        table.insert(v, {ox + size, oy - size, 0fx}) -- sets the third segment
        table.insert(v, {ox - size, oy + size, 0fx}) -- sets the final segment
        
        for k = 1, 4 do table.insert(c, 0x333333ff) end -- set up the color I change the color using the pewpew.set_mesh_color line in the level code but you can here
        
        table.insert(s, {base, base + 1}) -- draws the first two lines
        table.insert(s, {base + 2, base + 3}) --draws the second lines to make the x shape
    end
end
-- end
meshes = {{vertexes = v, segments = s, colors = c}} -- set up the mesh for pew pew live to see