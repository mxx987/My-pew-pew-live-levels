local Walls_setup = require("/dynamic/walls_set_up.lua")

-- Set how large the level will be.
local width = 1500fx
local height = 1500fx
pewpew.set_level_size(width, height)

--setup walls and background
setup_walls(0fx, 0fx,width)


local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_color(background, 0xB8860BFF)
pewpew.customizable_entity_set_mesh_z(background, -100fx)

local background2 = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/background_1.lua", 0)
pewpew.customizable_entity_set_mesh_color(background2, 0xB8860BFF)
pewpew.customizable_entity_set_mesh_z(background2, -200fx)

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, 
{shield = 1 ,move_joystick_color = 0xDAA520FF,            shoot_joystick_color = 0xffff00ff})


-- Configure the permanent weapon of the player's ship.
pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TIC_TOC})

local time = 0
local baf_spawn_interval = 15
local min_baf_interval = 8
local wary_spawn_interval = 190
local min_wary_interval = 120
local inertiac_spawn_interval = 400
local min_inertiac_interval = 240
local mothership_spawn_interval = 480
local min_mothership_interval = 320
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1


  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
  
  
  -- difficulty increase and shi
  if time % 30 == 0 and baf_spawn_interval > min_baf_interval then
    baf_spawn_interval = baf_spawn_interval - 1
  end
  
  if time % 60 == 0 and wary_spawn_interval > min_wary_interval then
    wary_spawn_interval = wary_spawn_interval - 2
  end
  
  if time % 90 == 0 and inertiac_spawn_interval > min_inertiac_interval then
    inertiac_spawn_interval = inertiac_spawn_interval - 4
  end
  
  if time % 120 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 6
  end
  
  -- end
  
  
  -- spawn enemys
if time % baf_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
  pewpew.new_baf(x, y, angle, 5fx, -1)
end

if time % wary_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_wary(x,y)
end

if time % inertiac_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
  pewpew.new_inertiac(x,y,1fx,angle)
end

if time % mothership_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
  pewpew.new_mothership(x,y,pewpew.MothershipType.FOUR_CORNERS,angle)
end

if time % 820 == 0 then
local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
 pewpew.new_bonus(x, y, pewpew.BonusType.WEAPON, {cannon = pewpew.CannonType.TRIPLE, frequency = pewpew.CannonFrequency.FREQ_10, weapon_duration = 240})
end

if time % 2400 == 0 then
local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
 pewpew.new_bonus(x, y, pewpew.BonusType.WEAPON, {cannon = pewpew.CannonType.HEMISPHERE, frequency = pewpew.CannonFrequency.FREQ_6, weapon_duration = 90})
end

    if time % 1200 == 0 then
        local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)