module(..., package.seeall)

require 'vector'

function update(x, y, velocity, dt)
   local position = vector.newWithXY(y, x)
   position = position:add(velocity)
   return position.y, position.x
end