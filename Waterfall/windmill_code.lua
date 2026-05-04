local windmills = {}


-- windmill
function new_windmill(x, y, ship_id)
    local wm = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(wm, "/dynamic/windmill_mesh.lua", 0)
    pewpew.entity_set_radius(wm, 15fx)
    
    
local current_angle = 0fx
    local rotation_speed = 0.900fx
    local is_dead = false
    
    pewpew.customizable_entity_set_weapon_collision_callback(wm, function(entity_id, weapon_type, weapon_x, weapon_y, p_index)
        if is_dead then return false end
        is_dead = true
        pewpew.increase_score_of_player(0, 25)
        pewpew.entity_set_radius(entity_id, 0fx)
        local ex, ey = pewpew.entity_get_position(entity_id)
        pewpew.play_sound("/dynamic/sounds.lua", 0, ex, ey)
        pewpew.customizable_entity_start_exploding(entity_id, 30)
    local x, y = pewpew.entity_get_position(wm)
    pewpew.create_explosion(x, y, 0x00ffffff, 1fx, 30)
    
        local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(ex, ey, 64)
        end
        return true
    end)
    
    pewpew.entity_set_update_callback(wm, function(entity_id)
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
    
      pewpew.customizable_entity_configure_wall_collision(wm , true , function()
    angle = angle * -1
  end)
  
    pewpew.customizable_entity_set_player_collision_callback(wm, function(entity_id, player_id, ship_id) 
        if is_dead then return end
        pewpew.add_damage_to_player_ship(ship_id, 1)
        pewpew.customizable_entity_start_exploding(entity_id, 20)
        is_dead = true
    end)
end

return windmills