pewpew.set_level_size(1000fx, 1000fx)
-- Background
local background = pewpew.new_customizable_entity(500fx, 500fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.entity_set_radius(background, 4000fx)
pewpew.customizable_entity_set_mesh_scale(background, 20fx)
pewpew.customizable_entity_set_mesh_z(background, -200fx)

local background2 = pewpew.new_customizable_entity(500fx, 500fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/background_2.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background2, 12fx)
pewpew.customizable_entity_set_mesh_z(background2, -100fx)
pewpew.entity_set_radius(background2, 4000fx)

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


local player_index = 0
pewpew.configure_player(player_index, {camera_distance = 50fx})

-- Create the players ship
local player_x = 500fx
local player_y = 500fx
local player_index = 0
local ship_id = pewpew.new_player_ship(player_x, player_y, player_index)

-- Configure the weapon
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
pewpew.configure_player_ship_weapon(ship_id, weapon_config)


pewpew.configure_player(0, {
  move_joystick_color = 0x0000ffff,
  shoot_joystick_color = 0x00ffffff
})






function spawn_windmill(x, y)
    local p1 = pewpew.new_customizable_entity(x, y)
 pewpew.customizable_entity_set_mesh(p1, "/dynamic/windmill_mesh.lua", 0)
    pewpew.entity_set_radius(p1, 15fx)

    local is_dead = false
    local internal_timer = fmath.random_int(0, 60)
    local dx = 0fx
    local dy = 0fx
    local current_angle = 0fx
 pewpew.customizable_entity_set_weapon_collision_callback(p1, function(entity_id, weapon_type, weapon_x, weapon_y, p_index)
        if is_dead then return false end
        is_dead = true
 pewpew.increase_score_of_player(0, 25)
 pewpew.entity_set_radius(entity_id, 0fx)
        local ex, ey = pewpew.entity_get_position(entity_id)
        pewpew.play_sound("/dynamic/sounds.lua", 0, ex, ey)
 pewpew.customizable_entity_start_exploding(entity_id, 30)
pewpew.increase_score_streak_of_player(0, 25)
  local streak_level = pewpew.get_score_streak_level(0)
  
  for i = 1, streak_level do
    pewpew.new_pointonium(ex, ey, 64)
    end
        return true
    end)
 pewpew.entity_set_update_callback(p1, function(entity_id)
        if is_dead then return end

        current_angle = current_angle + 0.999fx
 pewpew.customizable_entity_set_mesh_angle(entity_id, current_angle, 0fx, 0fx, 1fx)

        internal_timer = internal_timer + 1
        if internal_timer % 1 == 0 then
            local px, py = pewpew.entity_get_position(ship_id)
            local ex, ey = pewpew.entity_get_position(entity_id)
            local angle = fmath.atan2(py - ey, px - ex)
            local sin, cos = fmath.sincos(angle)
            dx = cos * 2.5fx
            dy = sin * 2.5fx
        end

        local ex, ey = pewpew.entity_get_position(entity_id) 
 pewpew.entity_set_position(entity_id, ex + dx, ey + dy)

        dx = dx * 0.95fx
        dy = dy * 0.95fx
    end)
 pewpew.customizable_entity_set_player_collision_callback(p1, function(entity_id, player_id, s_id) 
        if is_dead then return end
 pewpew.add_damage_to_player_ship(s_id, 1)
 pewpew.customizable_entity_start_exploding(entity_id, 20)
        is_dead = true
    end)
end


-- Create a new enemy every 101 tick

local time = 0
local baf_spawn_interval = 41
local min_baf_interval = 10
local windmill_spawn_interval = 60
local min_windmill_interval = 30
local mothership_spawn_interval = 881
local min_mothership_interval = 441
function level_tick()
  time = time + 1

  if time % 21 == 0 and baf_spawn_interval > min_baf_interval then
    baf_spawn_interval = baf_spawn_interval - 2
  end

--spawn bafs logic

if time % baf_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
  pewpew.new_baf_blue(x, y, angle, 5fx, -1)
end


-- windmill spawn

  if time % 51 == 0 and windmill_spawn_interval > min_windmill_interval then
    windmill_spawn_interval = windmill_spawn_interval - 2
  end
  
  --spawn windmills logic
if time % windmill_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
    spawn_windmill(x, y)
  end


--big wave
if time % 2541 == 0 then
  local angle = fmath.random_fixedpoint(0fx, fmath.tau())
pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(100fx, 900fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(100fx, 100fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
pewpew.new_mothership(900fx, 100fx, pewpew.MothershipType.SEVEN_CORNERS, angle )
end


if time % 111 == 0 and mothership_spawn_interval > min_mothership_interval then
    mothership_spawn_interval = mothership_spawn_interval - 6
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
  if time % 1251 == 5 then
        local x = fmath.random_fixedpoint(50fx, 900fx)
    local y = fmath.random_fixedpoint(50fx, 900fx)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(player_index)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
end

pewpew.add_update_callback(level_tick)