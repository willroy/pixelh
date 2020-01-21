local O = {}

local function load()
  x = 10
  y = 510
  acc = 6
  grav = 2
  ac = false
  dc = false
  wc = false
  sc = false
  fall = false
end

local function update()
  ac, dc, wc = false
  if collision(x-3, y, platforms) == false and love.keyboard.isDown("a","left") then x = x - 3 end
  if collision(x+3, y, platforms) == false and love.keyboard.isDown("d","right") then x = x + 3 end
  
  if love.keyboard.isDown("a","left") then ac = true end
  if love.keyboard.isDown("d","right") then dc = true end
  if love.keyboard.isDown("s","down") then sc = true end
  
  if love.keyboard.isDown("w","up") and fall == false then
    jump = true
    wc = true
  end
  
  if jump then
    if collision(x, y-(acc-0.2), platforms) == false and y-(acc-0.2) < 510 then 
      acc = acc - 0.2 
      y = y - acc 
    else 
      jump = false 
      acc = 6 
    end
  end
   
  if collision(x, y+grav, platforms) == false and (y+grav) < 510 then 
    y = y + grav 
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
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", x, y, 10, 10)
end

O.load = load
O.update = update
O.draw = draw

return O
