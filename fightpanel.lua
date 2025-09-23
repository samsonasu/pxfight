FightPanel = { }

function FightPanel:new(o, name)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  return o
end

function FightPanel:draw()
  local height = 150
  local width = love.graphics.getWidth() - 20
  local border = 4
  local margin = 10
  local round = 5

  util.setColorHex(util.colors.blue)
  love.graphics.rectangle("fill", margin, love.graphics.getHeight() - height - margin, width, height, round, round)
  util.setColorHex(util.colors.white)
  -- love.graphics.setColor(255,255,255,0.8)
  love.graphics.rectangle("fill", margin + border, love.graphics.getHeight() - height - margin + border, width - border * 2, height - border * 2, round, round)

end

function FightPanel:update(dt)

end
