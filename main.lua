local player = require("src/player")
local room = require("src/room")

function love.load()
  love.window.setMode(1300, 1000)
  love.graphics.setBackgroundColor(1,1,1)
  player.load()
  room.load()
end

function love.update(dt)
  player.update()
  room.update()
end

function love.draw()
  player.draw()
  room.draw()
end

function love.mousepressed(x, y, button, istouch)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end
