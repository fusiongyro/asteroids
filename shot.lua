Shot   = {}
function Shot:new(o, player)
   o = o or {}
   
   o.origin = {x = player.x, y = player.y}
   o.orientation = player.orientation
   o.distance_travelled = 0
   
   setmetatable(o, self)
   self.__index = self
   
   return o
end

function Shot:update(dt)
   o.distance_travelled = o.distance_travelled + dt * 100
   
   if (o.distance_travelled > 100) then
   end
end

function Shot:draw()
end
