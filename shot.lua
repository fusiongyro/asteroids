module(..., package.seeall)

Shot   = {}
function Shot:new(o, player)
   o = o or {}
   
   o.origin             = { x = player.x, y = player.y }
   o.location           = { x = player.x, y = player.y }
   o.orientation        = player.orientation
   o.player             = player
   o.distance_travelled = 0
   
   setmetatable(o, self)
   self.__index = self
   
   return o
end

function Shot:update(dt)
   self.distance_travelled = self.distance_travelled + dt * 500
   self.location.x = self.location.x + math.sin(self.orientation) * dt * 500
   self.location.y = self.location.y - math.cos(self.orientation) * dt * 500
   
   self.location.x = self.location.x % love.graphics.getWidth()
   self.location.y = self.location.y % love.graphics.getHeight()
end

function Shot:draw()
   love.graphics.circle('fill', self.location.x, self.location.y, 2.5)
end
