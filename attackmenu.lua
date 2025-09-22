AttackMenu = { }

function AttackMenu:new(o, hero)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.hero = hero

  return o
end


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

function AttackMenu:draw()
  drawbox()
end

function AttackMenu:update(dt)

end

function AttackMenu:keypressed(key, scancode, isrepeat)
  if key == "up" and selectedItem > 1 then
    selectedItem = selectedItem - 1
  elseif key == "down" and selectedItem < #attackmenu.items then
    selectedItem = selectedItem + 1
  elseif key == "return" then
    OnPlayerAction(attackmenu.items[selectedItem])
  end
end
