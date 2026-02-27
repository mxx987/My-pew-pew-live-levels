-- Set how large the level will be.
local width = 800fx
local height = 800fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background_grid = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background_grid, "/dynamic/background_grid.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background_grid, width / 20fx)
pewpew.customizable_entity_set_mesh_color(background_grid, 0xff0080ff)
pewpew.customizable_entity_set_mesh_z(background_grid, -500fx)
pewpew.customizable_entity_configure_music_response(background_grid,
{
    scale_x_start = 1fx,
    scale_x_end = 1.200fx,
    scale_y_start = 1fx,
    scale_y_end = 1.200fx,
 }
)


local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, width / 20fx)
pewpew.customizable_entity_set_mesh_color(background, 0xff0080ff)
pewpew.customizable_entity_set_mesh_z(background, -50fx)

local walls = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/walls.lua", 0)
pewpew.customizable_entity_set_mesh_scale(walls, width / 800fx)
pewpew.customizable_entity_set_mesh_color(walls, 0xff0080ff)

local dots = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(dots, "/dynamic/dots.lua", 0)
pewpew.customizable_entity_set_mesh_scale(dots, width / 20fx)
pewpew.customizable_entity_set_mesh_color(dots, 0xff0080ff)

local Pluss = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(Pluss, "/dynamic/Pluss.lua", 0)
pewpew.customizable_entity_set_mesh_scale(Pluss, width / 2fx)
pewpew.customizable_entity_set_mesh_color(Pluss, 0xff0080ff)

local flowers1 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(flowers1, "/dynamic/flowers.lua", 0)
pewpew.customizable_entity_set_mesh_scale(flowers1, width / 300fx)
pewpew.customizable_entity_set_mesh_color(flowers1, 0xff0080ff)
pewpew.customizable_entity_configure_music_response(flowers1,
{
    color_start = 0xff0080ff,
    color_end = 0xff00ffff,
    scale_x_start = 1fx,
    scale_x_end = 1.900fx,
    scale_y_start = 1fx,
    scale_y_end = 1.900fx,
 }
)

local flowers2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(flowers2, "/dynamic/flowers.lua", 1)
pewpew.customizable_entity_set_mesh_scale(flowers2, width / 300fx)
pewpew.customizable_entity_set_mesh_color(flowers2, 0xff0080ff)
pewpew.customizable_entity_configure_music_response(flowers2,
{
    color_start = 0xff0080ff,
    color_end = 0xff00ffff,
    scale_x_start = 1fx,
    scale_x_end = 1.900fx,
    scale_y_start = 1fx,
    scale_y_end = 1.900fx,
 }
)

-- Configure the player, with 2 shields.
pewpew.configure_player(0, {shield = 3})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, 200fx, 0)

pewpew.configure_player(0, {
  move_joystick_color = 0xff0080ff,
  shoot_joystick_color = 0xff00ffff
})

local time = 0
local angle = 0fx
local angle2 = 0fx
local bonusradius = 160fx
local max_bonusradius = 350fx
local mothership_spawn_interval = 130
local min_mothership_interval = 11
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1
  angle = angle + 0.100fx
  angle2 = angle2 + 0.50fx
  
    pewpew.customizable_entity_set_mesh_angle(flowers1, angle, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(flowers2, angle2, 0fx, 0fx, 1fx)
  
  if time % 60 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 1
  end
  
  if time % 1010 == 0 and max_bonusradius > bonusradius then
    bonusradius = bonusradius + 1fx
  end
  
  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end

  -- new mother ship
  if time % (mothership_spawn_interval // 2) == 0 then
    local x = width / 2fx
    local y = height / 2fx
local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x, y, pewpew.MothershipType.THREE_CORNERS, angle)
 end

  if time % (mothership_spawn_interval - 15) == 0 then
  local x = width / 2fx
  local y = height / 2fx
local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x, y, pewpew.MothershipType.FOUR_CORNERS, angle)
 end
 
   if time % (mothership_spawn_interval * 4) == 0 then
  local x = width / 2fx
  local y = height / 2fx
local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_super_mothership(x,y,pewpew.MothershipType.THREE_CORNERS,angle)
 end
 
 --new bonus area
   if time % 450 == 0 then
pewpew.new_weapon_zone(400fx, 400fx, pewpew.CannonType.HEMISPHERE, pewpew.CannonFrequency.FREQ_5, {
    radius = bonusradius,
    number_of_sides = 6
})
 end
 
 
 --small freezer bomb
   if time % 250 == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bomb(x, y, pewpew.BombType.SMALL_FREEZE)
 end
 
 --shield bonus
  if time % 2500 == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD, {number_of_shields = 3})
 end
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)