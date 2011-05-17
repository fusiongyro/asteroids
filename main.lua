function rotate(p, theta)
   local x = p.x * math.cos(theta) - p.y * math.sin(theta)
   local y = p.x * math.sin(theta) - p.y * math.cos(theta)
   return { x = x, y = y }
end


function love.load()
   love.filesystem.load('player.lua')()
   love.filesystem.load('shot.lua')()
   player = Player:new()
end

function love.update(dt)
   player:update(dt)
end

function love.draw()
   player:draw()
end