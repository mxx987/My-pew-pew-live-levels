-- Set how large the level will be.
local width = 1200fx
local height = 1200fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, width / 335fx)
pewpew.customizable_entity_set_mesh_color(background, 0xffd700ff)

local wall1 = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(wall1, "/dynamic/graphics.lua", 0)
pewpew.customizable_entity_set_mesh_scale(wall1, width / 1000fx)
pewpew.customizable_entity_set_mesh_color(wall1, 0xffff00ff)

local wall2 = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(wall2, "/dynamic/graphics.lua", 1)
pewpew.customizable_entity_set_mesh_scale(wall2, width / 1000fx)
pewpew.customizable_entity_set_mesh_color(wall2, 0xffff00ff)
pewpew.customizable_entity_set_mesh_angle(wall2, fmath.tau() / 64fx, 1fx, 0fx, 0fx)

local wall3 = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(wall3, "/dynamic/graphics.lua", 2)
pewpew.customizable_entity_set_mesh_scale(wall3, width / 1000fx)
pewpew.customizable_entity_set_mesh_color(wall3, 0xffff00ff)
pewpew.customizable_entity_set_mesh_angle(wall3, fmath.tau() / 32fx, 1fx, 0fx, 0fx)

local wall4 = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(wall4, "/dynamic/graphics.lua", 3)
pewpew.customizable_entity_set_mesh_scale(wall4, width / 1000fx)
pewpew.customizable_entity_set_mesh_color(wall4, 0xffff00ff)
pewpew.customizable_entity_set_mesh_angle(wall4, fmath.tau() / 16fx, 1fx, 0fx, 0fx)


-- Configure the player, with 2 shields.
pewpew.configure_player(0, {shield = 2})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)

pewpew.configure_player_ship_wall_trail(ship_id, {wall_length = 1800})

pewpew.configure_player(0, {
  move_joystick_color = 0xffff00ff,
  shoot_joystick_color = 0xffd700ff
})

local time = 0
local bafs_spawn_interval = 45
local min_bafs_interval = 10
local cubes_spawn_interval = 150
local min_cubes_interval = 25
local mothership_spawn_interval = 450
local min_mothership_interval = 100
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end

if time % 60 == 0 and bafs_spawn_interval > min_bafs_interval then
    bafs_spawn_interval = bafs_spawn_interval - 0.5
  end
  
  
  if time % 150 == 0 and cubes_spawn_interval > min_cubes_interval then
    cubes_spawn_interval = cubes_spawn_interval - 1.5
  end
  
  if time % 150 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 2
  end
  
  
  -- Every X amount of tick, create a new enemy
  if time % bafs_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
    pewpew.new_spiny(x ,y ,angle,1fx)
  end
  
    if time % cubes_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    pewpew.new_rolling_cube(x, y)
  end
  
  if time % mothership_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x,y,pewpew.MothershipType.FIVE_CORNERS,angle)
  end
  
  --shield pickups
  if time % 855 == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)