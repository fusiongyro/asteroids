module(..., package.seeall)

require 'shot'

Player = {}
function new(o)
   -- set up the player at the center of the screen
   o = o or {}

   o.radius = 10
   
   -- start at the center of the screen
   o.x = love.graphics.getWidth() / 2 
   o.y = love.graphics.getHeight() / 2
   
   o.velocity = 0
   o.angle = 0
   o.shots = {}
   
   o.image = love.graphics.newFramebuffer(32, 32)
   o.image:renderTo(function()
      love.graphics.setLineWidth(2.5)
      love.graphics.line(6, 31, 
                        26, 31, 
                        16,  2, 
                         6, 31)
   end)

   setmetatable(o, Player) 
   return o
end

function Player:shoot()
   self.shots[#self.shots+1] = shot.new(self)
end

function Player:draw()
   love.graphics.setColor(255, 255, 255, 255)
   love.graphics.draw(self.image, self.x, self.y, self.angle, 1, 1, 16, 16)
   
   for _, shot in ipairs(self.shots) do shot:draw() end
end

function Player:update(dt)
   -- handle acceleration/deceleration
   if love.keyboard.isDown('up') then
      self.velocity = self.velocity + dt * 3
   elseif love.keyboard.isDown('down') then
      self.velocity = self.velocity - dt * 3
   elseif love.keyboard.isDown('left') then
      self.angle = self.angle - dt * 3
   elseif love.keyboard.isDown('right') then
      self.angle = self.angle + dt * 3
   end
      
   -- handle rotation
   self.angle = self.angle % (2 * math.pi)
   
   -- handle movement
   self.y = self.y - (self.velocity * math.cos(self.angle))
   self.x = self.x + (self.velocity * math.sin(self.angle))
   
   -- handle wrapping
   self.x = self.x % love.graphics.getWidth()
   self.y = self.y % love.graphics.getHeight()
   
   -- now handle the shots
   for _, shot in ipairs(self.shots) do shot:update(dt) end
   
   -- remove any shots which are too old
   for i in pairs(self.shots) do
      if self.shots[i]:shouldBeRemoved() then
         table.remove(self.shots, i)
      end
   end
end

Player.__index = Player