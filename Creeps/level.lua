-- Set how large the level will be.
local width = 700fx
local height = 700fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
pewpew.customizable_entity_set_mesh_scale(background, width / 50fx)
pewpew.customizable_entity_set_mesh_color(background, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(background, -100fx)

local bg2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg2, "/dynamic/bg2.lua", 0)
pewpew.customizable_entity_set_mesh_scale(bg2, width / 20fx)
pewpew.customizable_entity_set_mesh_color(bg2, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(bg2, -200fx)

local bg3 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg3, "/dynamic/bg3.lua", 0)
pewpew.customizable_entity_set_mesh_scale(bg3, width / 7fx)
pewpew.customizable_entity_set_mesh_color(bg3, 0x999999ff)
pewpew.customizable_entity_set_mesh_z(bg3, -300fx)

local walls = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/walls.lua", 0)
pewpew.customizable_entity_set_mesh_scale(walls, width / 900fx)
pewpew.customizable_entity_set_mesh_color(walls, 0x999999ff)
-- Configure the player, with 2 shields.
pewpew.configure_player(0, {shield = 2})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
-- Configure the permanent weapon of the player's ship.

pewpew.entity_add_mace(ship_id, {
    distance = 120fx,
    angle = 0fx,
    rotation_speed = 0.800fx,
    type = pewpew.MaceType.DAMAGE_ENTITIES
})

pewpew.configure_player(0, {
  move_joystick_color = 0x999999ff,
  shoot_joystick_color = 0x999999ff
})


--normal death mace
function spawn_death_mace(x, y)
    local dm = pewpew.new_customizable_entity(x, y)

    pewpew.customizable_entity_set_mesh(dm, "/dynamic/death_mace_mesh.lua", 0)
    pewpew.entity_set_radius(dm, 15fx)
    
    pewpew.entity_add_mace(dm, {
    distance = 90fx,
    angle = 0fx,
    rotation_speed = 0.500fx,
    type = pewpew.MaceType.DAMAGE_PLAYERS
})
local current_angle = 0fx
    local rotation_speed = 0.500fx
    

    local is_dead = false
    
    pewpew.customizable_entity_set_weapon_collision_callback(dm, function(entity_id, weapon_type, weapon_x, weapon_y, p_index)
        if is_dead then return false end
        is_dead = true
        pewpew.increase_score_of_player(0, 100)
        pewpew.entity_set_radius(entity_id, 0fx)
        local ex, ey = pewpew.entity_get_position(entity_id)
        pewpew.play_sound("/dynamic/sounds.lua", 0, ex, ey)
        pewpew.customizable_entity_start_exploding(entity_id, 30)
        
        local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(ex, ey, 128)
        end
        return true
    end)
    
    pewpew.entity_set_update_callback(dm, function(entity_id)
        if is_dead then return end
        
        current_angle = current_angle + rotation_speed
        pewpew.customizable_entity_set_mesh_angle(entity_id, current_angle, 0fx, 0fx, 1fx)
        
        
        local px, py = pewpew.entity_get_position(ship_id)
        local ex, ey = pewpew.entity_get_position(entity_id)
        
        local angle = fmath.atan2(py - ey, px - ex)
        local sin, cos = fmath.sincos(angle)
        
        local speed = 2fx
        pewpew.entity_set_position(entity_id, ex + (cos * speed), ey + (sin * speed))
    end)
    
    pewpew.customizable_entity_set_player_collision_callback(dm, function(entity_id, player_id, s_id) 
        if is_dead then return end
        pewpew.add_damage_to_player_ship(s_id, 1)
        pewpew.customizable_entity_start_exploding(entity_id, 20)
        is_dead = true
    end)
end

-- dash death mace
function spawn_dash_mace(x, y)
    local lm = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(lm, "/dynamic/death_mace_mesh.lua", 0)
    pewpew.entity_set_radius(lm, 15fx)
    pewpew.entity_add_mace(lm, {distance = 30fx, angle = 0fx, rotation_speed = 0.999fx, type = pewpew.MaceType.DAMAGE_PLAYERS})
local current_angle = 0fx
    local rotation_speed = 1fx
    
    local timer = 0
    local dx, dy = 0fx, 0fx
    local is_dead = false

    pewpew.customizable_entity_set_weapon_collision_callback(lm, function(entity_id)
        if is_dead then return false end
        is_dead = true
        pewpew.increase_score_of_player(0, 150)
        local ex, ey = pewpew.entity_get_position(entity_id)
        pewpew.play_sound("/dynamic/sounds.lua", 1, ex, ey)
        pewpew.customizable_entity_start_exploding(entity_id, 30)
        for i = 1, pewpew.get_score_streak_level(0) do pewpew.new_pointonium(ex, ey, 128) end
        return true
    end)

    pewpew.entity_set_update_callback(lm, function(entity_id)
        if is_dead then return end
        current_angle = current_angle + rotation_speed
        pewpew.customizable_entity_set_mesh_angle(entity_id, current_angle, 0fx, 0fx, 1fx)
        
        timer = timer + 1
        local ex, ey = pewpew.entity_get_position(entity_id)
        
        if timer % 60 == 0 then
        pewpew.play_sound("/dynamic/sounds.lua", 2, ex, ey)
            local px, py = pewpew.entity_get_position(ship_id)
            local angle = fmath.atan2(py - ey, px - ex)
            local sin, cos = fmath.sincos(angle)
            dx, dy = cos * 12fx, sin * 12fx
        else
            dx, dy = (dx * 96fx) / 100fx, (dy * 96fx) / 100fx
        end
        pewpew.entity_set_position(entity_id, ex + dx, ey + dy)
    end)
end

local death_mace_spawn_interval = 501
local min_death_mace_interval = 301
local crowder_spawn_interval = 31
local min_crowder_interval = 9

local cube_spawn_interval = 71
local min_cube_interval = 41

local intertac_spawn_interval = 201
local min_intertac_interval = 71

local time = 0
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1

  if time % 150 == 0 and death_mace_spawn_interval > min_death_mace_interval then
    death_mace_spawn_interval = death_mace_spawn_interval - 1
  end

if time % 41 == 0 and crowder_spawn_interval > min_crowder_interval then
    crowder_spawn_interval = crowder_spawn_interval - 1
  end

if time % 61 == 0 and cube_spawn_interval > min_cube_interval then
    cube_spawn_interval = cube_spawn_interval - 1
  end
  
  if time % 91 == 0 and intertac_spawn_interval > min_intertac_interval then
    intertac_spawn_interval = intertac_spawn_interval - 1
  end


  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end

  -- Every X amount of tick, create a new enemy
  
  if time % crowder_spawn_interval == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
      
      pewpew.new_crowder(x, y)
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
    

if time %  (death_mace_spawn_interval // 2) == 0 then
local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
        spawn_death_mace(x,y)
    end
    
    if time % death_mace_spawn_interval == 0 then
local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
        spawn_dash_mace(x, y)
    end

 if time % 601 == 0 then
 local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)
pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
end
-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)