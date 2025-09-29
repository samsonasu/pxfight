FightPanel = { heroes={}, enemies={}}

function FightPanel:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  return o
end

function FightPanel:draw()
  local s = {
    height = 150,
    -- width = love.graphics.getWidth() - 20,
    width = 1280 - 20,
    x = 10,
    y = 720 - 150 - 10,
    border = 4,
    margin = 10,
    padding = 4,
    round = 5,
  }

  self:drawBox(s)
  self:drawParty(s)
  self:drawEnemies(s)
end

function FightPanel:update(dt)

end

function FightPanel:drawBox(s)
  love.graphics.setColor(1,1,1,.8)
  love.graphics.rectangle("fill", s.x, s.y, s.width, s.height, s.round, s.round)

  love.graphics.setLineWidth( 4 )
  util.setColorHex(util.colors.blue)
  love.graphics.rectangle("line", s.x, s.y, s.width, s.height, s.round, s.round)
  love.graphics.setColor(1,1,1)
  love.graphics.setLineWidth( 1 )

end

function FightPanel:drawParty(s)
  for i, hero in pairs(self.heroes) do
    love.graphics.setColor(0,0,0)
    local hero = self.heroes[i]
    local text = util.capitalize(hero.name) .. " (" .. hero.hp .. "hp)"
    love.graphics.print(text, s.x + s.padding, s.y + s.padding + i * love.graphics.getFont():getHeight() )
    love.graphics.setColor(1,1,1)
  end
end

function FightPanel:drawEnemies(s)
  for i, enemy in pairs(self.enemies) do
    love.graphics.setColor(0,0,0)
    local text = util.titlecase(self.enemies[i].name)
    local x = s.width - love.graphics.getFont():getWidth(text)

    love.graphics.print(text, x, s.y + s.padding + love.graphics.getFont():getHeight() * (i-1) )
    love.graphics.setColor(1,1,1)
  end
end
