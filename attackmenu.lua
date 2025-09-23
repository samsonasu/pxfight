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

  local w = 150
  local h = 20 * #self.attacks
  -- util.pp(self.hero)
  local y = self.hero.y
  local x = self.x

  love.graphics.setColor(20,0,220)
  love.graphics.rectangle("fill", x, y, w, h, cornerRadius, cornerRadius)

  love.graphics.setColor(255,255,255) -- reset colours
  love.graphics.rectangle("fill", x+2, y+2, w-4, h-4, cornerRadius, cornerRadius)

  for i = 1, #self.attacks do
    if i == selectedItem then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,0,0)
    end

    love.graphics.print(self.attacks[i], x + padding, y + padding + (i-1)*15)
  end
  love.graphics.setColor(255,255,255) -- reset colours

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
