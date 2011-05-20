module(..., package.seeall)

require 'vector'

Asteroid = {}

function new()
   local result = { x = math.random(love.graphics.getWidth()),
                    y = math.random(love.graphics.getHeight()),
                    velocity = vector.newWithMagnitudeAngle(math.random()+0.5, math.random() * math.pi * 2),
                    size = 40 }
   setmetatable(result, Asteroid)
   return result
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
   for _, asteroid in ipairs(asteroids) do asteroid:update(dt) end
end

function draw()
   for _, asteroid in ipairs(asteroids) do asteroid:draw() end
end

function Asteroid:update(dt)
   self.x, self.y = physics.update(self.x, self.y, self.velocity, dt)
end

function Asteroid:draw()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.circle('line', self.x, self.y, self.size)
   
   love.graphics.setColor(0, 0, 0, 255)
   love.graphics.circle('fill', self.x, self.y, self.size-2)
end

Asteroid.__index = Asteroid