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

local dots_background = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(dots_background, "/dynamic/random_dots.lua", 0)
pewpew.customizable_entity_set_mesh_scale(dots_background, width / 25fx)
pewpew.customizable_entity_set_mesh_color(dots_background, 0xff57331a)
pewpew.customizable_entity_set_mesh_z(dots_background, -1000fx)

local dots_background2 = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(dots_background2, "/dynamic/random_dots.lua", 0)
pewpew.customizable_entity_set_mesh_scale(dots_background2, width / 25fx)
pewpew.customizable_entity_set_mesh_color(dots_background2, 0xff57331a)
pewpew.customizable_entity_set_mesh_z(dots_background2, -1000fx)

-- Configure the player, with 2 shields.
pewpew.configure_player(0, {shield = 2})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)

pewpew.configure_player_ship_wall_trail(ship_id, {wall_length = 2250})

pewpew.configure_player(0, {
  move_joystick_color = 0xffff00ff,
  shoot_joystick_color = 0xffd700ff
})

local time = 0
local bafs_spawn_interval = 25
local min_bafs_interval = 15
local cubes_spawn_interval = 125
local min_cubes_interval = 30
local mothership_spawn_interval = 420
local min_mothership_interval = 90
local intertac_spawn_interval = 200
local min_intertac_interval = 67
local bomb_spawn_interval = 400
local min_bomb_interval = 200
local wave_spawn_interval = 420
local min_wave_interval = 280
local wave = 1
local entity_number = 2
local max_entity_number = 10
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
    cubes_spawn_interval = cubes_spawn_interval - 1
  end
  
  if time % 150 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 1
  end
  
    if time % 120 == 0 and intertac_spawn_interval > min_intertac_interval then
    intertac_spawn_interval = intertac_spawn_interval - 1
  end

if time % 500 == 0 and bomb_spawn_interval > min_bomb_interval then
    bomb_spawn_interval = bomb_spawn_interval - 1
  end
  
  if time % (wave_spawn_interval + 20) == 0 and wave_spawn_interval > min_wave_interval then
    wave_spawn_interval = wave_spawn_interval - 1
  end
  
  
  -- Every X amount of tick, create a new enemy
  
      -- wave function
    if time % wave_spawn_interval == 0 then
    wave = wave + 1
    
    if entity_number < max_entity_number then
    entity_number = wave + 4
    
    if entity_number > max_entity_number then
    entity_number = max_entity_number
    end
  end
    
  local wave_type = fmath.random_int(1, 3)
      if wave_type == 1 then
      for i = 1, 4 + 1 + (entity_number * 2) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_baf(x, y, angle, 10fx, -1)
      end
      elseif wave_type == 2 then
      for i = 1, 2 + 1 + (entity_number ) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_rolling_cube(x, y)
    end
    elseif wave_type == 3 then
      for i = 1, 1 + 1 + (entity_number - 4) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_mothership(x,y,pewpew.MothershipType.FIVE_CORNERS,angle)
    end
  end
end
    
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
  
  if time % intertac_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_inertiac(x, y, 1fx, angle)
      pewpew.new_bonus(x,y,pewpew.BonusType.SPEED,
  {
box_duration = 500,
speed_factor = 1.1fx,
speed_offset = 4fx,
speed_duration = 100})
    end
  
  --shield pickups
  if time % 900 == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
  
    if time % bomb_spawn_interval == 0 and bomb_type == 1 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.REPULSIVE)
bomb_type = 2

  elseif time % bomb_spawn_interval == 0 and bomb_type == 2 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.SMALL_ATOMIZE)
bomb_type = 1
  end
  
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)