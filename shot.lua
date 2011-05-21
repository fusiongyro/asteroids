module(..., package.seeall)

require 'asteroid'

Shot   = {}
function new(player)
   o = { angle      = player.angle,
         player     = player,
         travelled  = 0,
         alive      = true }

   o.origin   = { x = player.x, y = player.y }
   o.location = { x = player.x, y = player.y }
   
   setmetatable(o, Shot)
   
   return o
end

function Shot:update(dt)
   obj = { prev_x = self.location.x,
           prev_y = self.location.y,
           width  = 1,
           height = 1,
           original = self }
   self.travelled = self.travelled + dt * 500
   self.location.x = self.location.x + math.sin(self.angle) * dt * 500
   self.location.y = self.location.y - math.cos(self.angle) * dt * 500
   
   self.location.x = self.location.x % love.graphics.getWidth()
   self.location.y = self.location.y % love.graphics.getHeight()
   obj.x, obj.y = self.location.x, self.location.y
   collisionDetector:addObject(obj)
   collidableObjects[#collidableObjects+1] = obj
end

function Shot:draw()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle('fill', self.location.x, self.location.y, 2.5)
end

function Shot:shouldBeRemoved()
   -- have we gone too far?
   return not self.alive or self.travelled > 750
end

function Shot:remove()
   self.alive = false
end

-- double dispatch for post-collision handling
function Shot:collideWith(other)
   return other:collideWithShot(self)
end

-- ignore shot/shot and shot/player collisions
function Shot:collideWithShot(s) end
function Shot:collideWithPlayer(p) end

-- let asteroid handle shot/asteroid collisions
function Shot:collideWithAsteroid(ast)
   -- handle the asteroid end of this problem
   ast:collideWithShot(self)
end

Shot.__index = Shot
