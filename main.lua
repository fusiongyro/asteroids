require 'player'

function rotate(p, theta)
   local x = p.x * math.cos(theta) - p.y * math.sin(theta)
   local y = p.x * math.sin(theta) - p.y * math.cos(theta)
   return { x = x, y = y }
end

function love.keyreleased(key)
   if (key == ' ') then
      thePlayer:shoot()
   end
end

function love.load()
   thePlayer = player.Player:new()
end

function love.update(dt)
   thePlayer:update(dt)
end

function love.draw()
   thePlayer:draw()
end