Enemy = { name=nil, hp=10, x=0, y=0}

function Enemy:new(o, name)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.name = name

  self.sprite = love.graphics.newImage( "sprites/" .. self.name .. ".png" )
  return o
end

function Enemy:draw()
  local height = love.graphics.getHeight() / 2.0
  local width = height * 2.0 / 3.0

  love.graphics.draw(self.sprite, self.x, self.y, 0, width/self.sprite:getWidth(), height/self.sprite:getHeight())
end

function Enemy:update(dt)

end