module(..., package.seeall)

require 'vector'

function update(x, y, velocity, dt)
   local position = vector.newWithXY(y, x)
   position = position:add(velocity)
   return position.y, position.x
end

-- uses the global collision detector declared in the main file to try to 
-- detect collisions and handle them
function handleCollisions()
   for i, obj in ipairs(collidableObjects) do
      for j, other in ipairs(collisionDetector:getCollidableObjects(obj, true)) do
         obj.original:collideWith(other.original)
      end
   end
end