module(..., package.seeall)

Vector = {}

local function construct(o)
   setmetatable(o, Vector)
   return o
end

function newWithXY(x, y)
   return construct { x         = x, 
                      y         = y, 
                      magnitude = math.sqrt(math.pow(x, 2) + math.pow(y, 2)), 
                      theta     = math.atan(y / x) }
end

function newWithMagnitudeAngle(magnitude, theta)
   return construct { x         = magnitude * math.cos(theta),
                      y         = magnitude * math.sin(theta),
                      magnitude = magnitude,
                      theta     = theta }
end

function Vector:add(other)
   return newWithXY(self.x + other.x, self.y + other.y)
end

function Vector:show()
   return '<Vector x=' .. self.x .. ', y=' .. self.y .. '>'
end

Vector.__index = Vector
