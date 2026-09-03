-- Set how large the level will be.
local width = 700fx
local height = 700fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, width / 50fx)
pewpew.customizable_entity_set_mesh_color(background, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(background, -100fx)

local bg2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg2, "/dynamic/graphics/bg2.lua", 0)
pewpew.customizable_entity_set_mesh_scale(bg2, width / 20fx)
pewpew.customizable_entity_set_mesh_color(bg2, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(bg2, -200fx)

local bg3 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg3, "/dynamic/graphics/bg3.lua", 0)
pewpew.customizable_entity_set_mesh_scale(bg3, width / 7fx)
pewpew.customizable_entity_set_mesh_color(bg3, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(bg3, -300fx)

walls = pewpew.new_customizable_entity(0fx,0fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/graphics/walls.lua", 0)
pewpew.customizable_entity_set_mesh_scale(walls, width / 500fx)
pewpew.customizable_entity_set_mesh_color(walls, 0x999999ff)
pewpew.customizable_entity_start_spawning(walls, 120)
pewpew.customizable_entity_configure_music_response(walls, {color_start = 0x999999ff, color_end = 0xffffffff, scale_z_start = 1fx, scale_z_end = 2fx})

-- Configure the player, with 2 shields.
pewpew.configure_player(0, {
shield = 2,
move_joystick_color = 0x999999ff,
shoot_joystick_color = 0x999999ff})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
-- Configure the permanent weapon of the player's ship.

pewpew.entity_add_mace(ship_id, {
    distance = 120fx,
    angle = 0fx,
    rotation_speed = 0.800fx,
    type = pewpew.MaceType.DAMAGE_ENTITIES
})



local crowder_spawn_interval = 25
local min_crowder_interval = 7

local cube_spawn_interval = 69
local min_cube_interval = 31

local intertac_spawn_interval = 175
local min_intertac_interval = 61

local bonus_spawn_interval = 625
local min_bonus_interval = 480

local bomb_spawn_interval = 400
local min_bomb_interval = 200

local bomb_type = 1
local time = 0
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1

  

if time % 60 == 0 and crowder_spawn_interval > min_crowder_interval then
    crowder_spawn_interval = crowder_spawn_interval - 1
  end

if time % 90 == 0 and cube_spawn_interval > min_cube_interval then
    cube_spawn_interval = cube_spawn_interval - 1
  end
  
  if time % 90 == 0 and intertac_spawn_interval > min_intertac_interval then
    intertac_spawn_interval = intertac_spawn_interval - 1
  end

if time % 480 == 0 and bomb_spawn_interval > min_bomb_interval then
    bomb_spawn_interval = bomb_spawn_interval - 1
  end
  
  if time % 625 == 0 and bonus_spawn_interval > min_bonus_interval then
    bonus_spawn_interval = bonus_spawn_interval - 1
  end

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end

  -- Every X amount of tick, create a new enemy
  
  if time % crowder_spawn_interval == 0 then
  local spawn_point = fmath.random_int(1, 4)
   if spawn_point == 1 then
    pewpew.new_crowder(0fx, 0fx)
  elseif spawn_point == 2 then
    pewpew.new_crowder(0fx, 700fx)
   elseif spawn_point == 3 then
    pewpew.new_crowder(700fx, 0fx)
   else
    pewpew.new_crowder(700fx, 700fx)
    end
   end

if time % cube_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_rolling_cube(x,y)
    end
    
  if time % intertac_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_inertiac(x, y, 1fx, angle)
    end
    
 if time % bonus_spawn_interval == 0 then
pewpew.new_bonus(width / 2fx, height / 2fx, pewpew.BonusType.SHIELD)
  end
  
  if time % bomb_spawn_interval == 0 and bomb_type == 1 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.SMALL_FREEZE)
bomb_type = 2
  
  elseif time % bomb_spawn_interval == 0 and bomb_type == 2 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.REPULSIVE)
  bomb_type = 3
  
  elseif time % bomb_spawn_interval == 0 and bomb_type == 3 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.SMALL_ATOMIZE)
bomb_type = 1
  end

if time % (bonus_spawn_interval * 2) == 0 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
  pewpew.new_bonus(x,y,pewpew.BonusType.MACE,
 { box_duration = 400,mace_duration = 460 ,
    mace_radius = 150fx,
    angle = 0fx,
    mace_rotation = 0.500fx,} )
 end
 
 if time % (bonus_spawn_interval + 350) == 0 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    pewpew.new_bonus(x,y,pewpew.BonusType.SPEED,
  {
box_duration = 900,
speed_factor = 1.1fx,
speed_offset = 4fx,
speed_duration = 500})
 end
 
end
-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)