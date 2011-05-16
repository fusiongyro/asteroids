Player = {}

function Player:new(o)
   -- set up the player at the center of the screen
   o = o or {}

   o.radius = 10
   o.x = love.graphics.getWidth() / 2 
   o.y = love.graphics.getHeight() / 2
   o.velocity = 0
   o.orientation = 0

   setmetatable(o, self) 
   self.__index = self
   return o
end

function Player:draw()
   -- for now, pretend the player is a circle
   love.graphics.circle('line', self.x, self.y, self.radius, 20)
end

function Player:update(dt)
   -- handle acceleration/deceleration
   if love.keyboard.isDown('up') then
      player.velocity = player.velocity + dt*2
   elseif love.keyboard.isDown('down') then
      player.velocity = player.velocity - dt*2
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
end

function love.load()
   player = Player:new{}
end

function love.update(dt)
   player:update(dt)
end

function love.draw()
   player:draw()
end