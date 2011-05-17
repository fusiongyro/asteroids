Player = {}
function Player:new(o)
   -- set up the player at the center of the screen
   o = o or {}

   o.radius = 10
   o.x = love.graphics.getWidth() / 2 
   o.y = love.graphics.getHeight() / 2
   o.velocity = 0
   o.orientation = 0
   o.shots = {}
   o.image = love.graphics.newFramebuffer(32, 32)
   o.image:renderTo(function()
      love.graphics.setLineWidth(2)
      love.graphics.line(0, 32, 20, 32)
      love.graphics.line(20, 32, 10, 2)
      love.graphics.line(10, 2, 0, 32)
   end)

   setmetatable(o, self) 
   self.__index = self
   return o
end

function Player:shoot()
   o.shots[#o.shots+1] = Shot:new(self)
end

function Player:draw()
   love.graphics.draw(self.image, self.x, self.y, self.orientation)
   
   for _, shot in ipairs(player.shots) do
      shot:draw()
   end
end

function Player:update(dt)
   -- handle acceleration/deceleration
   if love.keyboard.isDown('up') then
      player.velocity = player.velocity + dt * 2
   elseif love.keyboard.isDown('down') then
      player.velocity = player.velocity - dt * 2
   elseif love.keyboard.isDown('left') then
      player.orientation = player.orientation - dt
   elseif love.keyboard.isDown('right') then
      player.orientation = player.orientation + dt
   end
      
   -- handle rotation
   player.orientation = player.orientation % (2 * math.pi)
   
   -- handle movement
   player.y = player.y - (player.velocity * math.cos(player.orientation))
   player.x = player.x + (player.velocity * math.sin(player.orientation))
   
   -- handle wrapping
   player.x = player.x % love.graphics.getWidth()
   player.y = player.y % love.graphics.getHeight()
   
   -- now handle the shots
   for _, shot in ipairs(player.shots) do
      shot:update(dt)
   end
end