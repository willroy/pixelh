local O = {}

local function load()
  platforms = {{100, 500, 50, 20}, {300, 500, 50, 20}, {200, 470, 50, 30}}
  mplatforms = {{400, 470, 50, 30, true}}   
end

local function update()
  for i=1,#mplatforms do
    if platforms[i][5] then
      if mplatforms[i][1] < 1100 or collision(mplatforms[i][1]+10, mplatforms[i][2], platforms) == false then
        mplatforms[i][1] = mplatforms[i][1] + 10
      elseif platforms[i][1] > 100 or collision(mplatforms[i][1]+10, mplatforms[i][2], platforms) == false then
        mplatforms[i][1] = mplatforms[i][1] - 10
      end
    end
  end
end

function collision(xnew, ynew, objects)
  for i=1,#objects do
    if xnew+10 > objects[i][1] and xnew < (objects[i][1]+objects[i][3]) then
      if ynew+10 > objects[i][2] and ynew < (objects[i][2]+objects[i][4]) then
        return true
      end
    end
  end
  return false
end


local function draw()
  love.graphics.setColor(0,0,1)
  for i=1,#platforms do
    love.graphics.rectangle("fill", platforms[i][1], platforms[i][2], platforms[i][3], platforms[i][4])
  end
  for i=1,#mplatforms do
    love.graphics.rectangle("fill", mplatforms[i][1], mplatforms[i][2], mplatforms[i][3], mplatforms[i][4])
  end
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill", 0, 520, 1200, 3)
end

O.load = load
O.update = update
O.draw = draw

return O
