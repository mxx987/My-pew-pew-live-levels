local Walls_setup = {}

function setup_walls(x,y,width)

local walls = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/walls_graphics.lua", 0)

local walls_space = width + 200fx

local walls2 = pewpew.new_customizable_entity(walls_space, 0fx)
pewpew.customizable_entity_set_mesh(walls2, "/dynamic/walls_graphics.lua", 0)

local walls3 = pewpew.new_customizable_entity(walls_space, walls_space)
pewpew.customizable_entity_set_mesh(walls3, "/dynamic/walls_graphics.lua", 0)

local walls4 = pewpew.new_customizable_entity(walls_space, walls_space * -1fx)
pewpew.customizable_entity_set_mesh(walls4, "/dynamic/walls_graphics.lua", 0)

local walls5 = pewpew.new_customizable_entity(0fx, walls_space * -1fx)
pewpew.customizable_entity_set_mesh(walls5, "/dynamic/walls_graphics.lua", 0)

local walls6 = pewpew.new_customizable_entity(0fx, walls_space)
pewpew.customizable_entity_set_mesh(walls6, "/dynamic/walls_graphics.lua", 0)


local walls7 = pewpew.new_customizable_entity(walls_space * -1fx, 0fx)
pewpew.customizable_entity_set_mesh(walls7, "/dynamic/walls_graphics.lua", 0)

local walls8 = pewpew.new_customizable_entity(walls_space * -1fx, walls_space * -1fx)
pewpew.customizable_entity_set_mesh(walls8, "/dynamic/walls_graphics.lua", 0)

local walls9 = pewpew.new_customizable_entity(walls_space * -1fx, walls_space)
pewpew.customizable_entity_set_mesh(walls9, "/dynamic/walls_graphics.lua", 0)
end

return Walls_setup