-- Set how large the level will be.
local width = 1200fx
local height = 1200fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(-2000fx, -2000fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics/graphics.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, 4fx)
pewpew.customizable_entity_set_mesh_z(background, -400fx)

walls = pewpew.new_customizable_entity(0fx , 0fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/graphics/graphics_walls.lua", 0)

lvl_floor = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(lvl_floor, "/dynamic/graphics/graphics_floor.lua", 0)
pewpew.customizable_entity_set_mesh_scale(lvl_floor, width / 640fx)
pewpew.customizable_entity_set_mesh_color(lvl_floor, 0x8000ffff)

-- Configure the player
pewpew.configure_player(0, {
  shield = 3,
  move_joystick_color = 0x0000ffff,
  shoot_joystick_color = 0x8000ffff
})





-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)

local time = 0
local baf_spawn_interval = 17
local min_baf_interval = 5
local inertiac_spawn_interval = 300
local min_inertiac_interval = 260
local wary_spawn_interval = 240
local min_wary_interval = 180
local zone_spawn_interval = 150
local min_zone_interval = 110
local wave_spawn_interval = 420
local min_wave_interval = 280
local bonus_spawn_interval = 600
local min_bonus_interval = 460
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
  
  -- spawn rates
  if time % 90 == 0 and baf_spawn_interval > min_baf_interval then
    baf_spawn_interval = baf_spawn_interval - 1
  end
  
  if time % 150 == 0 and inertiac_spawn_interval > min_inertiac_interval then
    inertiac_spawn_interval = inertiac_spawn_interval - 1
  end
  
  if time % 400 == 0 and wary_spawn_interval > min_wary_interval then
    wary_spawn_interval = wary_spawn_interval - 1
  end
  
  if time % 240 == 0 and zone_spawn_interval > min_zone_interval then
    zone_spawn_interval = zone_spawn_interval - 1
  end
  
    if time % (wave_spawn_interval + 20) == 0 and wave_spawn_interval > min_wave_interval then
    wave_spawn_interval = wave_spawn_interval - 1
  end
  
  if time % 500 == 0 and bonus_spawn_interval > min_bonus_interval then
   bonus_spawn_interval = bonus_spawn_interval - 1
  end
  
  if time % baf_spawn_interval == 0 then
  local baf_type = fmath.random_int(1, 3)
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      if baf_type == 1 then
      pewpew.new_baf_red(x,y,angle,3fx,-1)
      elseif baf_type == 2 then
      pewpew.new_baf_blue(x,y,angle,3fx,-1)
      else
      pewpew.new_baf(x,y,angle,3fx,-1)
    end
   end
    
    
    -- wave function
    if time % wave_spawn_interval == 0 then
    wave = wave + 1
    
    if entity_number < max_entity_number then
    entity_number = wave + 6
    
    if entity_number > max_entity_number then
    entity_number = max_entity_number
    end
  end
    
  local wave_type = fmath.random_int(1, 4)
      if wave_type == 1 then
      for i = 1, 6 + 1 + (entity_number * 2) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_crowder(x,y)
      end
      elseif wave_type == 2 then
      for i = 1, 1 + 1 + (entity_number - 1) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_rolling_cube(x, y)
     end
      elseif wave_type == 3 then
      for i = 1, 1 + 1 + (entity_number - 3) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_mothership(x,y,pewpew.MothershipType.FOUR_CORNERS,angle)
    end
    elseif wave_type == 4 then
      for i = 1, 2 + 1 + (entity_number * 8) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
         pewpew.new_brownian(x,y)
    end
  end
end
    
  if time % inertiac_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_inertiac(x, y, 1fx, angle)
    end
    
    if time % wary_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_wary(x,y)
    end
    
   if time % zone_spawn_interval == 0 then
   local x = fmath.random_fixedpoint(100fx, width - 100fx)
  local y = fmath.random_fixedpoint(100fx, height - 100fx)
pewpew.new_weapon_zone(x, y, pewpew.CannonType.DOUBLE, pewpew.CannonFrequency.FREQ_30, {
    radius = bonusradius
})
 end
 
 if time % (zone_spawn_interval * 9) == 0 then
   local x = fmath.random_fixedpoint(100fx, width - 100fx)
  local y = fmath.random_fixedpoint(100fx, height - 100fx)
pewpew.new_weapon_zone(x, y, pewpew.CannonType.HEMISPHERE, pewpew.CannonFrequency.FREQ_3, {
    radius = bonusradius,
    number_of_sides = 6
})
 end
 
 if time % bonus_spawn_interval == 0 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
  
  if time % (bonus_spawn_interval * 4) == 0 then
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