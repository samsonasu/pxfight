Alert = { text="Hello World", time=3.0 }

function Alert:new(o, text)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Alert:draw(x, y)
  if self.isVisible then
    local shake = 5.0
    local shakeX = (math.random() * shake) - shake / 2.0
    local shakeY = (math.random() * shake) - shake / 2.0
    local rot = math.random() * 0.01 - 0.005
    love.graphics.print(self.text, 100 + shakeX, 300 + shakeY, rot, 2, 2 )
  end
end

function Alert:show()
  self.isVisible = true
  self.visibleTime = 0
end

function Alert:update(dt)
  if self.isVisible == false then return end

  if self.visibleTime >= self.time then
    self.isVisible = false
    self.visibleTime = nil
    return
  else
    self.visibleTime = self.visibleTime + dt
  end
end
