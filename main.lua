require 'player'
require 'starfield'
require 'asteroid'
require 'quadtree/quadtree'

local QuadTree = quadtree.QuadTree

-- some utility functions
function rotate(p, theta)
   local x = p.x * math.cos(theta) - p.y * math.sin(theta)
   local y = p.x * math.sin(theta) - p.y * math.cos(theta)
   return { x = x, y = y }
end

-- LÖVE callbacks
function love.keyreleased(key)
   if (key == ' ') then
      thePlayer:shoot()
   end
end

function love.load()
   love.window.setMode(1024, 768)
   starfield.load()
   thePlayer = player.new()
   asteroid.load()
end

function love.update(dt)
   collisionDetector = QuadTree.new(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
   for i = 1, 6 do collisionDetector:subdivide() end
   collidableObjects = {}
   starfield.update(dt)
   thePlayer:update(dt)
   asteroid.update(dt)
   physics.handleCollisions()
end

function love.draw()
   starfield.draw()
   thePlayer:draw()
   asteroid.draw()
   love.graphics.setColor(255,255,255,255)
   --love.graphics.print('FPS: '.. love.timer.getFPS(), 100, 100)
end
