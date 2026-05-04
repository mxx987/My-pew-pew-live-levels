local windmills = require("/dynamic/windmill_code.lua")

pewpew.set_level_size(1000fx, 1000fx)
-- Background
local background = pewpew.new_customizable_entity(500fx, 500fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, 20fx)
pewpew.customizable_entity_set_mesh_z(background, -200fx)

local background2 = pewpew.new_customizable_entity(500fx, 500fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/background_2.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background2, 12fx)
pewpew.customizable_entity_set_mesh_z(background2, -100fx)
pewpew.customizable_entity_configure_music_response(background2,
{
    color_start = 0x0000ffa1,
    color_end = 0x00ffffa1,
    scale_x_start = 1fx,
    scale_x_end = 1.200fx,
    scale_y_start = 1fx,
    scale_y_end = 1.200fx,
 }
)


-- The walls
local Walls1 = pewpew.new_customizable_entity(500fx, 500fx) 
pewpew.customizable_entity_set_mesh(Walls1, "/dynamic/graphics.lua", 0)
-- The walls2
local Walls2 = pewpew.new_customizable_entity(500fx, 500fx) 
pewpew.customizable_entity_set_mesh(Walls2, "/dynamic/graphics.lua", 1)
-- The walls3
local Walls3 = pewpew.new_customizable_entity(500fx, 500fx) 
pewpew.customizable_entity_set_mesh(Walls3, "/dynamic/graphics.lua", 2)
-- The walls4
local Walls4 = pewpew.new_customizable_entity(500fx, 500fx) 
pewpew.customizable_entity_set_mesh(Walls4, "/dynamic/graphics.lua", 3)
-- The walls5
local Walls5 = pewpew.new_customizable_entity(500fx, 500fx) 
pewpew.customizable_entity_set_mesh(Walls5, "/dynamic/graphics.lua", 4)

local ship_id = pewpew.new_player_ship(500fx, 500fx, 0)

-- Configure the weapon
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
pewpew.configure_player_ship_weapon(ship_id, weapon_config)


pewpew.configure_player(0, {
  move_joystick_color = 0x0000ffff,
  shoot_joystick_color = 0x00ffffff
})

local time = 0
local baf_spawn_interval = 41
local min_baf_interval = 10
local windmill_spawn_interval = 60
local min_windmill_interval = 30
local mothership_spawn_interval = 881
local min_mothership_interval = 441


function level_tick()
  time = time + 1

  if time % 30 == 0 and baf_spawn_interval > min_baf_interval then
    baf_spawn_interval = baf_spawn_interval - 1
  end

--spawn bafs logic

if time % baf_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
  pewpew.new_baf_blue(x, y, angle, 5fx, -1)
end


-- windmill spawn

  if time % 60 == 0 and windmill_spawn_interval > min_windmill_interval then
    windmill_spawn_interval = windmill_spawn_interval - 1
  end
  
  --spawn windmills logic
if time % windmill_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
    new_windmill(x, y, ship_id)
  end


--big wave
if time % 2400 == 0 then
pewpew.new_floating_message(500fx, 500fx, "#0x00ffffffTSUNAMI!", {scale = 2.5fx, ticks_before_fade = 30, is_optional = true})
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(100fx, 900fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(100fx, 100fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(900fx, 100fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
end


if time % 120 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 5
  end
  
--cyan mother ship
  if time % (mothership_spawn_interval // 2) == 0 then
local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
  local angle = fmath.random_fixedpoint(0fx, 180fx)
pewpew.new_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, angle)
end

--big cyan mother ship
    if time % mothership_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
  local angle = fmath.random_fixedpoint(0fx, 180fx)
pewpew.new_super_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, angle)
end

--shield pickups
  if time % 1200 == 0 then
        local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
end

pewpew.add_update_callback(level_tick)
