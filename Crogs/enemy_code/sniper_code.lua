local snipers = {}


--snipe bullet
function new_snipe_bullet(x, y, angle)
  local zp = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(zp, 0)
  pewpew.customizable_entity_set_mesh(zp, "/dynamic/assets/snipe_bullet.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(zp, true)
  pewpew.entity_set_radius(zp, 10fx)
  -- Make the bullet move
  local dy, dx = fmath.sincos(angle)
  dx = dx * 15fx
  dy = dy * 15fx
  pewpew.entity_set_update_callback(zp, function()
    local x,y = pewpew.entity_get_position(zp)
    x = x + dx
    y = y + dy
    pewpew.entity_set_position(zp, x, y)
  end)


  pewpew.customizable_entity_configure_wall_collision(zp, false, function()
    pewpew.customizable_entity_start_exploding(zp, 10)
    
  end)
  
  pewpew.customizable_entity_set_player_collision_callback(zp, function(entity_id, player_id, ship_id)
    pewpew.add_damage_to_player_ship(ship_id, 1)
    pewpew.customizable_entity_start_exploding(entity_id, 10)
    
  end)
end


-- snipe enemy
function new_sniper(x, y, ship_id)
  local sp = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(sp, "/dynamic/assets/snipe_mesh.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(sp, true)
  pewpew.entity_set_radius(sp, 40fx)
local hp = 9
local is_hit_recently = false

pewpew.customizable_entity_set_weapon_collision_callback(sp, function(entity_id, player_index, weapon_type)
  if hp > 0 then
    hp = hp - 1
      pewpew.increase_score_of_player(0, 10)
local x, y = pewpew.entity_get_position(sp)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 2, x, y)
    pewpew.create_explosion(x, y, 0x0000ffff, 1fx, 2)
    is_hit_recently = true
  end
  
  if hp <= 0 then
  pewpew.increase_score_of_player(0, 150)
    pewpew.customizable_entity_start_exploding(sp, 10)
    local x, y = pewpew.entity_get_position(sp)
    pewpew.create_explosion(x, y, 0x3357ffff, 1fx, 90)
    pewpew.entity_destroy(sp)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 3, x, y)
            local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(x, y, 128)
        end
    return true
  end
  return true
end)

  -- sniper hit and shoot logic
  local time = 0
  local dy = 5fx
pewpew.entity_set_update_callback(sp, function()
if is_hit_recently then
pewpew.customizable_entity_set_mesh(sp, "/dynamic/assets/snipe_hit_mesh.lua", 0)
is_hit_recently = false
  else
pewpew.customizable_entity_set_mesh(sp, "/dynamic/assets/snipe_mesh.lua", 0)
        
end
  time = time + 1
  if time == 60 then
    time = 0
    local x, y = pewpew.entity_get_position(sp)
    local px, py = pewpew.entity_get_position(ship_id)
    local angle = fmath.atan2(py - y, px - x)
    pewpew.customizable_entity_set_mesh_angle(sp, angle, 0fx, 0fx, 1fx)
    new_snipe_bullet(x, y, angle)
    pewpew.play_sound("/dynamic/sounds/other_sounds.lua", 0, x, y)
   end
 end)
end


return snipers