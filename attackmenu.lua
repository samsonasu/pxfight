AttackMenu = {hero=nil, x=0, y=0 }

function AttackMenu:new(o, hero, attacks)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.hero = hero
  o.attacks = attacks
  print("new attack menu for: " .. hero.name .. " at " .. hero.x .. ", ")
  util.pp(hero)
  return o
end

local padding = 10

local selectedItem = 1
local alertText = nil
local alertTime = nil

function AttackMenu:drawbox()
  local cornerRadius = 10
  local fontheight = love.graphics.getFont():getHeight()
  local w = 150
  local h = 20 + fontheight * #self.attacks
  local y = self.hero.y + 50
  local x = self.hero.x + 100

  -- love.graphics.setColor(1,1,1, 0.8)
  util.setColorHex(util.colors.blue .. "AA")
  love.graphics.rectangle("fill", x, y, w, h, cornerRadius, cornerRadius)

  love.graphics.setColor(.2,0,.8)
  love.graphics.rectangle("line", x, y, w, h, cornerRadius, cornerRadius)
  love.graphics.setColor(1,1,1)


  for i = 1, #self.attacks do
    if i == selectedItem then
      love.graphics.setColor(1,1,1)
    else
      love.graphics.setColor(0.7, 0.7, 0.7)
    end

    love.graphics.print(self.attacks[i], x + padding, y + padding + (i-1)*fontheight)
  end
  love.graphics.setColor(1,1,1) -- reset colours

end

function AttackMenu:draw()
  self:drawbox()
end

function AttackMenu:update(dt)

end

function AttackMenu:keypressed(key, scancode, isrepeat)
  if key == "up" and selectedItem > 1 then
    selectedItem = selectedItem - 1
  elseif key == "down" and selectedItem < #self.attacks then
    selectedItem = selectedItem + 1
  elseif key == "return" then
    OnPlayerAction(self.attacks[selectedItem])
  end
end
