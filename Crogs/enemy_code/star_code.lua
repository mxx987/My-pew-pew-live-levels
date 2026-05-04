local stars = {}


--star bullet
function new_star_bullet(x, y, angle)
  local sb = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(sb, 0)
  pewpew.customizable_entity_set_mesh(sb, "/dynamic/assets/star_bullet.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(sb, true)
  pewpew.entity_set_radius(sb, 10fx)
  -- Make the bullet move
  local dy, dx = fmath.sincos(angle)
  dx = dx * 4fx
  dy = dy * 4fx
  pewpew.entity_set_update_callback(sb, function()
    local x,y = pewpew.entity_get_position(sb)
    x = x + dx
    y = y + dy
    pewpew.entity_set_position(sb, x, y)
  end)

  pewpew.customizable_entity_configure_wall_collision(sb, false, function()
    pewpew.customizable_entity_start_exploding(sb, 10)
    
  end)
  
  pewpew.customizable_entity_set_player_collision_callback(sb, function(entity_id, player_id, ship_id)
    pewpew.add_damage_to_player_ship(ship_id, 1)
    pewpew.customizable_entity_start_exploding(entity_id, 10)
  end)
end

--  star enemy
function new_star(x, y)
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(id, "/dynamic/assets/star_mesh.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(id, true)
  pewpew.entity_set_radius(id, 40fx)
local hp = 6
local is_hit_recently = false

pewpew.customizable_entity_set_weapon_collision_callback(id, function(entity_id, player_index, weapon_type)
  if hp > 0 then
    hp = hp - 1
      pewpew.increase_score_of_player(0, 10)
local x, y = pewpew.entity_get_position(id)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 0, x, y)
    pewpew.create_explosion(x, y, 0x0000ffff, 1fx, 2)
    is_hit_recently = true
  end
  
  if hp <= 0 then
  pewpew.increase_score_of_player(0, 75)
    pewpew.customizable_entity_start_exploding(id, 10)
    local x, y = pewpew.entity_get_position(id)
    pewpew.create_explosion(x, y, 0x3357ffff, 1fx, 90)
    pewpew.entity_destroy(id)
    pewpew.play_sound("/dynamic/sounds/death_sounds.lua", 1, x, y)
            local streak_level = pewpew.get_score_streak_level(0)
        for i = 1, streak_level do
            pewpew.new_pointonium(x, y, 128)
        end
    return true
  end
  return true
end)

  -- star's hit and shoot logic
  local time = 0
  local dy = 5fx
pewpew.entity_set_update_callback(id, function()
if is_hit_recently then
pewpew.customizable_entity_set_mesh(id, "/dynamic/assets/star_hit_mesh.lua", 0)
is_hit_recently = false
  else
pewpew.customizable_entity_set_mesh(id, "/dynamic/assets/star_mesh.lua", 0)
        
end
  time = time + 1
  if time == 15 then
    time = 0
    local x, y = pewpew.entity_get_position(id)
    local angle = fmath.random_fixedpoint(0fx, fmath.tau())
    new_star_bullet(x, y, angle)
   end
 end)
end




return stars