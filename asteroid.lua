module(..., package.seeall)

require 'vector'
require 'quadtree/quadtree'

Asteroid = {}

function new()
   return setmetatable(
   { x = math.random(love.graphics.getWidth()),
     y = math.random(love.graphics.getHeight()),
     velocity = vector.newWithMagnitudeAngle(math.random()+0.5, math.random() * math.pi * 2),
     size = 40 }, Asteroid)
end

function generateLevel(level)
   asteroids = {}
   for i = 1, (level + 1) * 5 do
      asteroids[#asteroids+1] = new()
   end
end

function load()
   generateLevel(1)
end

function update(dt)
   index = {}
   -- update each asteroid's position
   for i, asteroid in ipairs(asteroids) do 
      -- build inverse table for our collision detector
      index[asteroid] = i
      asteroid:update(dt) 
   end
end

function draw()
   for _, asteroid in ipairs(asteroids) do asteroid:draw() end
end

function Asteroid:update(dt)
   local obj = { prev_x = self.x - self.size/2, 
                 prev_y = self.y - self.size/2,
                 height = self.size, width = self.size,
                 original = self }
   self.x, self.y = physics.update(self.x, self.y, self.velocity, dt)
   self.x = self.x % love.graphics.getWidth()
   self.y = self.y % love.graphics.getHeight()
   obj.x, obj.y = self.x, self.y
   collisionDetector:addObject(obj)
   collidableObjects[#collidableObjects+1] = obj
end

function Asteroid:draw()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle('line', self.x, self.y, self.size)
   
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.circle('fill', self.x, self.y, self.size-2)
end

function Asteroid:pointCollisionAt(x, y)
   dx, dy = self.x - x, self.y - y
   return (dx * dx) + (dy * dy) < ((self.size + 1) * (self.size + 1))
end

-- double dispatch for post collision handling
function Asteroid:collideWith(other)
   return other:collideWithAsteroid(self)
end

function Asteroid:collideWithShot(s) 
   -- remove this asteroid from the map
   if index[self] then
      table.remove(asteroids, index[self])
      index[self] = nil
      s:remove()
   end
end

function Asteroid:collideWithPlayer(p) 
   p:collideWithAsteroid(self)
end

function Asteroid:collideWithAsteroid(ast) end

Asteroid.__index = Asteroid