module(..., package.seeall)

require 'vector'
require 'shot'
require 'physics'

Player = {}
function new(o)
   -- set up the player at the center of the screen
   o = o or {}

   o.radius = 10
   
   -- start at the center of the screen
   o.x = love.graphics.getWidth() / 2 
   o.y = love.graphics.getHeight() / 2
   
   o.velocity = vector.newWithMagnitudeAngle(0, 0)
   o.angle = 0
   o.shots = {}
   o.alive = true
   
   o.image = love.graphics.newFramebuffer(32, 32)
   o.image:renderTo(function()
      love.graphics.setLineWidth(2.5)
      local polygon = {  6, 31, 
                        26, 31, 
                        16,  2, 
                         6, 31 }
      love.graphics.polygon('line', polygon)
   end)
   o.gameover = love.graphics.newFramebuffer()
   o.gameover:renderTo(function()
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.setFont(96)
      love.graphics.printf('GAME OVER', 200, 300, 10000, 'left')
   end)

   setmetatable(o, Player) 
   return o
end

function Player:shoot()
   self.shots[#self.shots+1] = shot.new(self)
end

function Player:draw()
   if self.alive then
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, 16, 16)
   else
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(self.gameover)
   end
   
   for _, shot in ipairs(self.shots) do shot:draw() end
end

function Player:update(dt)
   -- handle acceleration/deceleration
   if love.keyboard.isDown('up') then
      self.velocity = self.velocity:add(vector.newWithMagnitudeAngle(-dt * 3, -self.angle))
   elseif love.keyboard.isDown('down') then
      self.velocity = self.velocity:add(vector.newWithMagnitudeAngle(dt * 3, -self.angle))
   elseif love.keyboard.isDown('left') then
      self.angle = self.angle - dt * 3
   elseif love.keyboard.isDown('right') then
      self.angle = self.angle + dt * 3
   end
      
   -- handle rotation
   self.angle = self.angle % (2 * math.pi)
   
   local obj = { prev_x = self.x - 6,
                 prev_y = self.y,
                 width = 20,
                 height = 30,
                 original = self }
   
   -- handle movement
   self.x, self.y = physics.update(self.x, self.y, self.velocity, dt)
   
   -- handle wrapping
   self.x = self.x % love.graphics.getWidth()
   self.y = self.y % love.graphics.getHeight()
   
   obj.x, obj.y = self.x, self.y
   collisionDetector:addObject(obj)
   collidableObjects[#collidableObjects+1] = obj
   
   -- now handle the shots
   for _, shot in ipairs(self.shots) do shot:update(dt) end
   
   -- remove any shots which are too old
   for i in pairs(self.shots) do
      if self.shots[i]:shouldBeRemoved() then
         table.remove(self.shots, i)
      end
   end
end

-- double dispatch for post-collision handling
function Player:collideWith(other)
   return other:collideWithPlayer(self)
end

-- ignore interaction with myself or shots
function Player:collideWithShot(s) end
function Player:collideWithPlayer(p) end

-- end the game when this happens
function Player:collideWithAsteroid(ast) 
   self.alive = false
end


Player.__index = Player