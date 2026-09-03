-- Set how large the level will be.
local width = 900fx
local height = 900fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(width / 2fx , height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, width / 170fx)
pewpew.customizable_entity_set_mesh_color(background, 0x0000ffff)
pewpew.customizable_entity_set_mesh_z(background, -10fx)
pewpew.customizable_entity_configure_music_response(background,
{
    color_start = 0x0000ffff,
    color_end = 0xffffffff,
    scale_x_start = 1fx,
    scale_x_end = 1.050fx,
    scale_y_start = 1fx,
    scale_y_end = 1.050fx,
 }
)

local stars_bac = pewpew.new_customizable_entity(-2000fx , -1000fx)
pewpew.customizable_entity_set_mesh(stars_bac, "/dynamic/background_stars.lua", 0)
pewpew.customizable_entity_set_mesh_color(stars_bac, 0x3357ffff)
pewpew.customizable_entity_set_mesh_z(stars_bac, -1000fx)
pewpew.customizable_entity_set_mesh_scale(stars_bac, width / 100fx)

-- Configure the player, with 2 shields.
pewpew.configure_player(0, {
  shield = 2,
  move_joystick_color = 0x0000ffff,
  shoot_joystick_color = 0x3357ffff
})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
-- Configure the permanent weapon of the player's ship.
pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_6, cannon = pewpew.CannonType.SHOTGUN})

local time = 0
local wave_spawn_interval = 240
local min_wave_interval = 120
local wave = 1
local last_wave = 1
local entity_number = 2
local max_entity_number = 16


-- first wave
local first_wave_type = fmath.random_int(1, 7)
      if first_wave_type == 1 then
      for i = 1, 7 + 1 + (entity_number * 9) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_baf_blue(x, y, angle, 10fx, -1)
      end
      elseif first_wave_type == 2 then
      for i = 1, 5 + 1 + (entity_number * 10) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_crowder(x,y)
     end
      elseif first_wave_type == 3 then
      for i = 1, 1 + 1 + (entity_number - 3) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x,y,pewpew.MothershipType.SEVEN_CORNERS,angle)
    end
    elseif first_wave_type == 4 then
      for i = 1, 4 + 1 + (entity_number + 2 ) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_kamikaze(x,y,angle)
    end
    elseif first_wave_type == 5 then
      for i = 1, 2 + 1 + (entity_number - 2) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x,y,pewpew.MothershipType.SEVEN_CORNERS,angle)
pewpew.new_kamikaze(x,y,angle)
    end
    elseif first_wave_type == 6 then
      for i = 1, 6 + 1 + (entity_number * 5) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_baf_blue(x, y, angle, 10fx, -1)
pewpew.new_crowder(x,y)
    end
    elseif first_wave_type == 7 then
      for i = 1, 5 + 1 + (entity_number + 2) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_baf_blue(x, y, angle, 10fx, -1)
pewpew.new_kamikaze(x,y,angle)
    end
  end
  -- first wave

-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
  
  
  -- spawn rates
      if time % (wave_spawn_interval + 20) == 0 and wave_spawn_interval > min_wave_interval then
    wave_spawn_interval = wave_spawn_interval - 1
  end
  

  -- wave function
    if time % wave_spawn_interval == 0 then
    last_wave = wave
    wave = wave + 1
    pewpew.increase_score_of_player(0, 400 * wave)
    
    if entity_number < max_entity_number then
    entity_number = wave + 5
    
    if entity_number > max_entity_number then
    entity_number = max_entity_number
    end
  end
    
  local wave_type = fmath.random_int(1, 7)
      if wave_type == 1 then
      for i = 1, 7 + 1 + (entity_number * 9) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_baf_blue(x, y, angle, 10fx, -1)
      end
      elseif wave_type == 2 then
      for i = 1, 5 + 1 + (entity_number * 10) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      pewpew.new_crowder(x,y)
     end
      elseif wave_type == 3 then
      for i = 1, 1 + 1 + (entity_number - 3) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x,y,pewpew.MothershipType.SEVEN_CORNERS,angle)
    end
    elseif wave_type == 4 then
      for i = 1, 4 + 1 + (entity_number + 2 ) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_kamikaze(x,y,angle)
    end
    elseif wave_type == 5 then
      for i = 1, 2 + 1 + (entity_number - 5) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(x,y,pewpew.MothershipType.SEVEN_CORNERS,angle)
pewpew.new_kamikaze(x,y,angle)
    end
    elseif wave_type == 6 then
      for i = 1, 6 + 1 + (entity_number * 4) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_baf_blue(x, y, angle, 10fx, -1)
pewpew.new_crowder(x,y)
    end
    elseif wave_type == 7 then
      for i = 1, 5 + 1 + (entity_number + 2) do
          local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_baf_blue(x, y, angle, 10fx, -1)
pewpew.new_kamikaze(x,y,angle)
    end
  end
end
  
  if last_wave % 3 == 0 then
  last_wave = 1
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
  
  if last_wave % 5 == 0 then
  last_wave = 1
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.WEAPON, {cannon = pewpew.CannonType.HEMISPHERE, frequency = pewpew.CannonFrequency.FREQ_3, weapon_duration = 240})
  end
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)