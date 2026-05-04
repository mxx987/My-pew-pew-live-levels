local stars = require("/dynamic/enemy_code/star_code.lua")
local super_stars = {}


--super star bullet
function new_super_star_bullet(x, y, angle)
  local ssb = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(ssb, 0)
  pewpew.customizable_entity_set_mesh(ssb, "/dynamic/assets/super_star_bullet.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(ssb, true)
  pewpew.entity_set_radius(ssb, 10fx)
  local current_angle = 0fx
    local rotation_speed = 0.900fx
  -- Make the bullet move
  local dy, dx = fmath.sincos(angle)
  dx = dx * 6fx
  dy = dy * 6fx
  pewpew.entity_set_update_callback(ssb, function()
    local x,y = pewpew.entity_get_position(ssb)
    x = x + dx
    y = y + dy
    pewpew.entity_set_position(ssb, x, y)
    current_angle = current_angle + rotation_speed
        pewpew.customizable_entity_set_mesh_angle(ssb, current_angle, 0fx, 0fx, 1fx)
  end)

  pewpew.customizable_entity_configure_wall_collision(ssb, false, function()
    pewpew.customizable_entity_start_exploding(ssb, 10)
  end)
  
  pewpew.customizable_entity_set_player_collision_callback(ssb, function(entity_id, player_id, ship_id)
    pewpew.add_damage_to_player_ship(ship_id, 2)
    pewpew.customizable_entity_start_exploding(entity_id, 10)
  end)
end


-- super star (boss)
function new_super_star(x, y, ship_id)
  local ss = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(ss, "/dynamic/assets/super_star_mesh.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(ss, true)
  pewpew.entity_set_radius(ss, 40fx)
local hp = 50
local is_hit_recently = false
local boss_attack = 1
pewpew.customizable_entity_set_weapon_collision_callback(ss, function(entity_id, player_index, weapon_type)
  if hp > 0 then
    hp = hp - 1
      pewpew.increase_score_of_player(0, 5)
local x, y = pewpew.entity_get_position(ss)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 5, x, y)
    pewpew.create_explosion(x, y, 0x0000ffff, 1fx, 2)
    is_hit_recently = true
  end
  
  if hp <= 0 then
  pewpew.increase_score_of_player(0, 500)
    pewpew.customizable_entity_start_exploding(ss, 10)
    local x, y = pewpew.entity_get_position(ss)
    pewpew.create_explosion(x, y, 0x3357ffff, 1fx, 90)
    pewpew.entity_destroy(ss)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 6, x, y)
            local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(x, y, 512)
        end
    return true
  end
  return true
end)

  

  -- boss hit and attack logic
  local time = 0
  local dy = 5fx
pewpew.entity_set_update_callback(ss, function()
if is_hit_recently then
pewpew.customizable_entity_set_mesh(ss, "/dynamic/assets/super_star_hit_mesh.lua", 0)
is_hit_recently = false
  else
pewpew.customizable_entity_set_mesh(ss, "/dynamic/assets/super_star_mesh.lua", 0)
end
  time = time + 1
  
  if time % 120 == 0 then
  boss_attack = fmath.random_int(1, 3)
  end
  
  if time % 5 == 0 and boss_attack == 1 then
    local x, y = pewpew.entity_get_position(ss)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
    new_super_star_bullet(x, y, angle)
    end
    
 if time % 60 == 0 and boss_attack == 2 then
 local x, y = pewpew.entity_get_position(ss)
 new_star(x, y)
 pewpew.create_explosion(x, y, 0x3357ffff, 1fx, 30)
    local px, py = pewpew.entity_get_position(ship_id)
    pewpew.entity_set_position(ss, px, py )
    pewpew.play_sound("/dynamic/sounds/other_sounds.lua", 1, px, px)
    end
    
    if time % 10 == 0 and boss_attack == 3 then
     local x, y = pewpew.entity_get_position(ss)
    local px, py = pewpew.entity_get_position(ship_id)
    local angle = fmath.atan2(py - y, px - x)
    new_super_star_bullet(x, y, angle)
    pewpew.play_sound("/dynamic/sounds/other_sounds.lua", 0, x, y)
    end
 end)
end


return super_stars