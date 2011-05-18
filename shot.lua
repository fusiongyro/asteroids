module(..., package.seeall)

Shot   = {}
function new(player)
   o = { angle      = player.angle,
         player     = player,
         travelled  = 0 }

   o.origin   = { x = player.x, y = player.y }
   o.location = { x = player.x, y = player.y }
   
   setmetatable(o, Shot)
   
   return o
end

function Shot:update(dt)
   self.travelled = self.travelled + dt * 500
   self.location.x = self.location.x + math.sin(self.angle) * dt * 500
   self.location.y = self.location.y - math.cos(self.angle) * dt * 500
   
   self.location.x = self.location.x % love.graphics.getWidth()
   self.location.y = self.location.y % love.graphics.getHeight()
end

function Shot:draw()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle('fill', self.location.x, self.location.y, 2.5)
end

function Shot:shouldBeRemoved()
   return self.travelled > 750
end

Shot.__index = Shot
