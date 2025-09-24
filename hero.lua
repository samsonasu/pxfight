require "attackmenu"

Hero = { name = "hero", sprite = nil, hp = 10, x = 0, y = 0}

local STATS = {
  knight = {
    hp = 10,
    mp = 0,
    attacks = { "Attack", "Defend", "Nerd Out"}
  }
}

local attackTranslateTime = nil
local attackTranslateX = 0

local function calcAttackTranslate(dt)
  local mtime = .07
  local duration = 1.5
  local maxx = 50

  attackTranslateTime = attackTranslateTime + dt
  if attackTranslateTime < mtime then
    attackTranslateX = math.ceil(attackTranslateTime * maxx/mtime)
  elseif attackTranslateTime < duration - mtime then
    attackTranslateX = maxx
  elseif attackTranslateTime < duration then
    attackTranslateX = maxx - ((attackTranslateTime - duration + mtime) * maxx/mtime)
  else
    attackTranslateX = 0
    attackTranslateTime = nil
  end
end

local shader = love.graphics.newShader("shaders/outline.glsl")

function Hero:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  o.sprite = love.graphics.newImage( "sprites/" .. o.name .. ".png" )
  o.attackmenu = AttackMenu:new(nil, o, STATS[o.name].attacks)

  return o
end

function Hero:draw()
  local height = love.graphics.getHeight() / 5
  local width = height * 2 / 3

  love.graphics.draw(self.sprite, self.x + attackTranslateX, self.y, 0, width/self.sprite:getWidth(), height/self.sprite:getHeight())

  if self.isActive then
    love.graphics.setShader(shader)
    love.graphics.draw(self.sprite, self.x + attackTranslateX, self.y, 0, width/self.sprite:getWidth(), height/self.sprite:getHeight())
    love.graphics.setShader()
  end
end

function Hero:update(dt)
  if attackTranslateTime ~= nil then
    calcAttackTranslate(dt)
  end
end

function Hero:animateAttack()
  attackTranslateTime = 0
end

