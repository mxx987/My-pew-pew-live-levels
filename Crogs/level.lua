-- enemys code loader
local windmills = require("/dynamic/enemy_code/windmill_code.lua")
local stars = require("/dynamic/enemy_code/star_code.lua")
local snipers = require("/dynamic/enemy_code/sniper_code.lua")
local super_stars = require("/dynamic/enemy_code/super_star_code.lua")
local arrows = require("/dynamic/enemy_code/arrow_code.lua")

-- Set how large the level will be.
local width = 1500fx
local height = 1000fx
pewpew.set_level_size(width, height)

-- the walls, background
local walls = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(walls, "/dynamic/assets/graphics.lua", 0)
pewpew.customizable_entity_set_mesh_color(walls, 0x0000ffff)
pewpew.customizable_entity_set_mesh_xyz_scale(walls, 1.5fx,1fx,1fx)

local walls2 = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(walls2, "/dynamic/assets/walls.lua", 0)
pewpew.customizable_entity_set_mesh_color(walls2, 0x0000ffff)

local stars_bac = pewpew.new_customizable_entity(-1000fx, -500fx)
pewpew.customizable_entity_set_mesh(stars_bac, "/dynamic/assets/background_stars.lua", 0)
pewpew.customizable_entity_set_mesh_color(stars_bac, 0x0000ffbf)
pewpew.customizable_entity_set_mesh_scale(stars_bac, width / 50fx)
pewpew.customizable_entity_set_mesh_z(stars_bac, -1000fx)


local stars_bac2 = pewpew.new_customizable_entity(-1000fx, -500fx)
pewpew.customizable_entity_set_mesh(stars_bac2, "/dynamic/assets/background_stars.lua", 0)
pewpew.customizable_entity_set_mesh_color(stars_bac2, 0x0000ff1a)
pewpew.customizable_entity_set_mesh_scale(stars_bac2, width / 50fx)
pewpew.customizable_entity_set_mesh_z(stars_bac2, -1500fx)


local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/assets/background.lua", 0)
pewpew.customizable_entity_set_mesh_color(background, 0x0000ffff)
pewpew.customizable_entity_set_mesh_scale(background, width / 60fx)

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 4fx, height / 2fx, 0)

pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC})

pewpew.configure_player(0, {
  move_joystick_color = 0x0000ffff,
  shoot_joystick_color = 0x0000ffff
})

pewpew.add_wall(900fx, 900fx, 1000fx, 800fx)
pewpew.add_wall(1000fx, 800fx, 900fx, 700fx)
pewpew.add_wall(900fx, 700fx, 800fx, 600fx)
pewpew.add_wall(800fx, 600fx, 900fx, 900fx)

pewpew.add_wall(200fx, 200fx, 300fx, 300fx)
pewpew.add_wall(300fx, 300fx, 200fx, 400fx)
pewpew.add_wall(200fx, 400fx, 100fx, 300fx)
pewpew.add_wall(100fx, 300fx, 200fx, 200fx)

local spawn_points = {
  {x = 400fx, y = 900fx},
  {x = 700fx, y = 150fx},
  {x = 800fx, y = 200fx},
  {x = 1200fx, y = 200fx}
}


local x = 0fx
local y = 0fx
local time = 0

-- start and min time for it to spawn
local windmill_spawn_interval = 30
local min_windmill_interval = 15

local arrow_spawn_interval = 90
local min_arrow_interval = 30

local star_spawn_interval = 140
local min_star_interval = 60

local sniper_spawn_interval = 260
local min_sniper_interval = 140




-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
  
  -- decrease timers
  if time % 140 == 0 and windmill_spawn_interval > min_windmill_interval then
    windmill_spawn_interval = windmill_spawn_interval - 1
  end
  
  if time % 140 == 0 and arrow_spawn_interval > min_arrow_interval then
    arrow_spawn_interval = arrow_spawn_interval - 1
  end
  
  if time % 140 == 0 and star_spawn_interval > min_star_interval then
    star_spawn_interval = star_spawn_interval - 1
  end
  
  if time % 140 == 0 and sniper_spawn_interval > min_sniper_interval then
    sniper_spawn_interval = sniper_spawn_interval - 1
  end
  
      if time % windmill_spawn_interval == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    new_windmill(x, y, ship_id)
  end
    
      if time % arrow_spawn_interval == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    new_arrow(x, y, ship_id)
  end
    
      if time % star_spawn_interval == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    new_star(x, y)
  end
    
      if time % sniper_spawn_interval == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    new_sniper(x, y, ship_id)
  end
    
      if time % 1400 == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    new_super_star(x, y, ship_id)
  end
  
  if time % 500 == 0 then
      local spawnpoint = fmath.random_int(1, 2)
      if spawnpoint == 1 then
    x = fmath.random_fixedpoint(0fx, 700fx)
    y = fmath.random_fixedpoint(500fx, 1000fx)
    else
    x = fmath.random_fixedpoint(700fx, 1400fx)
    y = fmath.random_fixedpoint(0fx, 650fx)
    end
    pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD)
  end
  
end
-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)