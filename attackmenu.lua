local attackmenu = { items = {"Attack", "Defend", "Nerd out"} }

local padding = 10

local w = 150
local h = 20 * #attackmenu.items
local y = love.graphics.getHeight() - h - padding
local x = padding

local selectedItem = 1
local alertText = nil
local alertTime = nil

local function drawbox()
  local cornerRadius = 10

  love.graphics.setColor(20,0,220)
  love.graphics.rectangle("fill", x, y, w, h, cornerRadius, cornerRadius)

  love.graphics.setColor(255,255,255) -- reset colours
  love.graphics.rectangle("fill", x+2, y+2, w-4, h-4, cornerRadius, cornerRadius)

  for i = 1, #attackmenu.items do
    if i == selectedItem then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,0,0)  
    end

    love.graphics.print(attackmenu.items[i], x + padding, y + padding + (i-1)*15)
  end
  love.graphics.setColor(255,255,255) -- reset colours

end

local function drawAlert() 
  if alertText == nil then return end
  local shake = 30.0
  local shakeX = (math.random() * shake) - shake / 2.0
  local shakeY = (math.random() * shake) - shake / 2.0
  love.graphics.print(alertText, 300 + shakeX, 300 + shakeY, 0, 2, 2 )
end

function attackmenu.draw(dt)
  drawbox()
  drawAlert()
  -- love.graphics.print("ATTACK", x + padding, y + padding)
end

function attackmenu.update(dt)
  if alertText == nil then return end
  if alertTime == nil then
    alertTime = 0
  elseif alertTime >= 2.0 then
    alertText = nil
    alertTime = nil
    return
  else 
    alertTime = alertTime + dt
  end
end

function attackmenu.keypressed(key, scancode, isrepeat)
  if key == "up" and selectedItem > 1 then
    selectedItem = selectedItem - 1
  elseif key == "down" and selectedItem < #attackmenu.items then 
    selectedItem = selectedItem + 1
  elseif key == "return" then
    print(attackmenu.items[selectedItem])
    alertText = "Player performs " .. attackmenu.items[selectedItem] .. "!\nIt was not effective!"
  end
end


return attackmenu