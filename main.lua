local attackmenu = require "attackmenu"

function love.load()
  love.window.setMode( 1024, 768, { resizable=true } )

  playerX = love.graphics.getWidth() / 3
  playerY = love.graphics.getHeight() * 3 / 4

  local manaspace = love.graphics.newFont("fonts/manaspc.ttf", 14)

  love.graphics.setFont(manaspace)
end

function love.update(dt)
  playerSpeed = 10
  if love.keyboard.isDown("d") then
    playerX = playerX + playerSpeed
  elseif love.keyboard.isDown("a") then
    playerX = playerX - playerSpeed
  elseif love.keyboard.isDown("s") then
    playerY = playerY + playerSpeed
  elseif love.keyboard.isDown("w") then
    playerY = playerY - playerSpeed
  end
  attackmenu.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
  attackmenu.keypressed(key, scancode, isrepeat)
end

function love.draw()
  
  local bg = love.graphics.newImage( "bg/cave.png" )
  love.graphics.draw(bg)
   

  local knight = love.graphics.newImage( "sprites/knight1.png" )
  local height = love.graphics.getHeight() / 5
  local width = height * 2 / 3
  love.graphics.draw(knight, playerX, playerY, 0, -width/knight:getWidth(), height/knight:getHeight())

  attackmenu.draw()
end
