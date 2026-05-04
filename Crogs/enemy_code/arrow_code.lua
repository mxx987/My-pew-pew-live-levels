local arrows = {}


-- arrow code
function new_arrow(x, y, ship_id)
    local ar = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(ar, "/dynamic/assets/arrow_mesh.lua", 0)
    pewpew.entity_set_radius(ar, 15fx)
    
local hp = 1
local is_hit_recently = false

pewpew.customizable_entity_set_weapon_collision_callback(ar, function(entity_id, player_index, weapon_type)
  if hp < 5 then
    hp = hp + 1
      pewpew.increase_score_of_player(0, 5)
local x, y = pewpew.entity_get_position(ar)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 7, x, y)
    pewpew.create_explosion(x, y, 0x0000ffff, 1fx, 2)
    is_hit_recently = true
  end
  
  if hp >= 5 then
  pewpew.increase_score_of_player(0, 50)
    pewpew.customizable_entity_start_exploding(ar, 10)
    local x, y = pewpew.entity_get_position(ar)
    pewpew.create_explosion(x, y, 0x3357ffff, 1fx, 90)
    pewpew.entity_destroy(ar)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 8, x, y)
            local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(x, y, 64)
        end
    return true
  end
  return true
end)


pewpew.entity_set_update_callback(ar, function()
if is_hit_recently then
pewpew.customizable_entity_set_mesh(ar, "/dynamic/assets/arrow_hit_mesh.lua", 0)
is_hit_recently = false
  else
pewpew.customizable_entity_set_mesh(ar, "/dynamic/assets/arrow_mesh.lua", 0)
end

        local px, py = pewpew.entity_get_position(ship_id)
        local ex, ey = pewpew.entity_get_position(ar)
        
        local angle = fmath.atan2(py - ey, px - ex)
        local sin, cos = fmath.sincos(angle)
    
        
        local speed = 1fx * fmath.to_fixedpoint(hp)
            local next_x = ex + (cos * speed)
    local next_y = ey + (sin * speed)
        pewpew.entity_set_position(ar, next_x,next_y)
        pewpew.customizable_entity_set_mesh_angle(ar, angle, 0fx, 0fx, 1fx)
    end)
    
      pewpew.customizable_entity_configure_wall_collision(ar , true , function()
    angle = angle * -1
  end)
  
    pewpew.customizable_entity_set_player_collision_callback(ar, function(entity_id, player_id, ship_id) 
        pewpew.add_damage_to_player_ship(ship_id, 1)
        pewpew.customizable_entity_start_exploding(entity_id, 20)
        is_dead = true
    end)
end


return arrows