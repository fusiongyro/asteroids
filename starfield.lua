module(..., package.seeall)

function load()
   -- let's choose, say, 1/100 pixels to be a star
   width  = love.graphics.getWidth()
   height = love.graphics.getHeight()
   
   nstars = width * height / 1000
   
   stars = {}
   
   for i = 1, nstars do
      stars[i] = newStar(width, height)
   end
end

function update(dt)
   -- loop through all the stars updating their brightness
   for _, star in ipairs(stars) do
      star.brightness = star.brightness + dt / star.rate
   end
end

function draw()
   for _, star in ipairs(stars) do
      love.graphics.setColor(255, 255, 255, 127 * math.abs(math.cos(star.brightness)))
      love.graphics.circle('fill', star.x, star.y, 1)
   end
end

function newStar(width, height)
   return { x          = math.random(0, width - 1),
            y          = math.random(0, height - 1),
            brightness = math.random() * 2 * math.pi,
            rate       = math.random(4) }
end
