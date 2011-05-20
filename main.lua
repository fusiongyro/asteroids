require 'player'
require 'starfield'
require 'asteroid'

-- some utility functions
function rotate(p, theta)
   local x = p.x * math.cos(theta) - p.y * math.sin(theta)
   local y = p.x * math.sin(theta) - p.y * math.cos(theta)
   return { x = x, y = y }
end

-- LÖVE callbacks
function love.keyreleased(key)
   if (key == ' ') then
      thePlayer:shoot()
   end
end

function love.load()
   love.graphics.setMode(1024, 768)
   starfield.load()
   thePlayer = player.new()
   asteroid.load()
end

function love.update(dt)
   starfield.update(dt)
   thePlayer:update(dt)
   asteroid.update(dt)
end

function love.draw()
   starfield.draw()
   thePlayer:draw()
   asteroid.draw()
   --love.graphics.print('FPS: '.. love.timer.getFPS(), 100, 100)
end
