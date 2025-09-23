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

  if self.isActive then
    love.graphics.setColor(12, 24, 165, 0.5)
    love.graphics.circle("fill", self.x + width/2, self.y + height/2, width)
    love.graphics.setColor(255,255,255)
  end

  love.graphics.draw(self.sprite, self.x + attackTranslateX, self.y, 0, width/self.sprite:getWidth(), height/self.sprite:getHeight())
end

function Hero:update(dt)
  self.psystem:update(dt)
  if attackTranslateTime ~= nil then
    calcAttackTranslate(dt)
  end
end

function Hero:activate()
  local psystem = love.graphics.newParticleSystem(self.sprite, 32)
	psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(50)
	psystem:setSizeVariation(1)
	psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

  self.psystem = psystem
end

function Hero:animateAttack()
  attackTranslateTime = 0
end

