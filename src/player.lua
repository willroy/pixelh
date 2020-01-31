local O = {}

local function load()
  x = 10
  y = 480
  acc = 6
  grav = 2
  ac = false
  dc = false
  wc = false
  sc = false
  fall = false
  image = love.graphics.newImage("assets/slime.png")
  quad1 = love.graphics.newQuad(0, 0, 20, 20, image:getWidth(), image:getHeight())
  quad2 = love.graphics.newQuad(20, 0, 20, 20, image:getWidth(), image:getHeight())
  quad3 = love.graphics.newQuad(40, 0, 20, 20, image:getWidth(), image:getHeight())
  quad4 = love.graphics.newQuad(60, 0, 20, 20, image:getWidth(), image:getHeight())
  quad5 = love.graphics.newQuad(0, 40, 20, 20, image:getWidth(), image:getHeight())
  quad6 = love.graphics.newQuad(20, 40, 20, 20, image:getWidth(), image:getHeight())
  walk = {quad1, quad2, quad3, quad4}
  idle = {quad5, quad6}
  p = {10, 480, image}
  count = 0
  frame = 1
  counti = 0
  framei = 1
end

local function update()
  ac, dc, wc = false
  
  if collision(p[1]-3, p[2], platforms) == false and love.keyboard.isDown("a","left") then p[1] = p[1] - 3 end
  if collision(p[1]+3, p[2], platforms) == false and love.keyboard.isDown("d","right") then p[1] = p[1] + 3 end
  
  if love.keyboard.isDown("a","left") then ac = true end
  if love.keyboard.isDown("d","right") then dc = true end
  if love.keyboard.isDown("s","down") then sc = true end
  
  if love.keyboard.isDown("w","up") and fall == false then jump = true end
  if love.keyboard.isDown("w","up") then wc = true end
  
  if jump then
    if collision(p[1], p[2]-(acc-0.2), platforms) == false and p[2]-(acc-0.2) < 480 then 
      acc = acc - 0.2 
      p[2] = p[2] - acc 
    else 
      jump = false 
      acc = 6 
    end
  end
   
  if collision(p[1], p[2]+grav, platforms) == false and (p[2]+grav) < 480 then 
    p[2] = p[2] + grav 
    fall = true
  else fall = false end
end

local function draw()
  love.graphics.setColor(0.5,0.5,0.5)
  love.graphics.rectangle("fill", 1090, 900, 50, 50)
  love.graphics.rectangle("fill", 1150, 840, 50, 50)
  love.graphics.rectangle("fill", 1150, 900, 50, 50)
  love.graphics.rectangle("fill", 1210, 900, 50, 50)
  love.graphics.setColor(0,0,0)
  if ac then love.graphics.rectangle("fill", 1090, 900, 50, 50) end
  if wc then love.graphics.rectangle("fill", 1150, 840, 50, 50) end
  if dc then love.graphics.rectangle("fill", 1210, 900, 50, 50) end
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill", p[1], p[2], 10, 10)
  if ac or dc then 
    count = count + 1
    if count == 20 then
      frame = frame + 1
      count = 0
    end
    love.graphics.draw(image, walk[frame], p[1], p[2], 0, 2, 2)
    if frame == 4 then frame = 1 end
  else
    counti = counti + 1
    if counti == 40 then
      if framei == 2 then framei = 1
      else framei = framei + 1 end
      counti = 0
    end    
    love.graphics.draw(image, idle[framei], p[1], p[2], 0, 2, 2)
  end
end

O.load = load
O.update = update
O.draw = draw

return O
