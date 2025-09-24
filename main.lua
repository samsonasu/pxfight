require("util")
require("hero")
require("enemy")
require("alert")
require("attackmenu")
require("fightpanel")

-- This file probably becomes FightScene.lua at some point in the future

local hero = Hero:new{name="knight"}
local enemy = Enemy:new(nil, "sloth_king")
local alert = Alert:new{}
local fightpanel = FightPanel:new(nil)
local frames = {hero, enemy, alert, fightpanel}

local stateframes = {}
local heroes = {}
local enemies = {}

local bg = love.graphics.newImage( "bg/cave.png" )
local bgm = nil

STATES = {"player", "enemy", "win", "lose"}
local currentState = nil
local queuedState = nil

local defenseFactor = 1
local attackFactor = 1

function love.load()
  love.window.setMode( 1024, 768, { resizable=true } )
  love.graphics.setDefaultFilter("nearest", "nearest")
  local manaspace = love.graphics.newFont("fonts/manaspc.ttf", 16)
  love.graphics.setFont(manaspace)

  setMusic("battle2")

  hero.x = 100
  hero.y = love.graphics.getHeight() - 350
  table.insert(heroes, hero)

  enemy.x = love.graphics.getWidth() * .75
  enemy.y = 100
  table.insert(enemies, enemy)

  fightpanel.enemies = enemies
  fightpanel.heroes = heroes

  setState("player")

  alert:show()
end

function love.update(dt)
  for i,f in ipairs(frames) do
    f:update(dt)
  end

  for i,f in ipairs(stateframes) do
    if f.update then f:update(dt) end
  end

  if queuedState then
    queuedState.ttl = queuedState.ttl - dt
    -- print("queuedState: " .. queuedState.state .. " ttl: " .. queuedState.ttl)
    if queuedState.ttl < 0 then
      setState(queuedState.state)
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  for i,f in ipairs(stateframes) do
    if f.keypressed then
      f:keypressed(key, scancode, isrepeat)
    end
  end

  if key == "f" then
    alert.text = "F IN THE CHAT"
    alert:show()
  end
end

function love.draw()
  love.graphics.draw(bg)
  for i,f in ipairs(frames) do
    f:draw()
  end
  for i,f in ipairs(stateframes) do
    f:draw()
  end
end

function setMusic(music)
  if bgm then
    print("Stopping existing music")
    bgm:stop()
  end

  bgm = love.audio.newSource("music/" .. music .. ".mp3", "stream")
  bgm:setVolume(.5)
  bgm:play()
end

function soundEffect(sfx)
  if not string.match(sfx, "%.") then
    sfx = sfx .. ".wav"
  end

  local sound = love.audio.newSource("sfx/" .. sfx, "static")
  sound:play()
end

function setState(state)
  queuedState = nil
  if currentState == state then return end

  print("setState: " .. state)
  stateframes = {} -- maybe need destructors here
  hero.isActive = false
  if state == "player" then
    hero.isActive = true
    table.insert(stateframes, hero.attackmenu)
  elseif state == "enemy" then
    OnEnemyAction("Attack")
  elseif state == "win" then
    setMusic("victory")
  elseif state == "lose" then
    setMusic("nevergiveup")
  end
  currentState = state
end

function queueState(state, delay)
  print("queueState:" .. state .. " in " .. delay)
  queuedState = {state = state, ttl = delay}
end

function OnPlayerAction(action)
  print(action)
  if action == "Attack" then
    soundEffect("26_sword_hit_1")
    local dmg = math.floor(math.random() * 10) * attackFactor
    attackFactor = 1
    enemy.hp = enemy.hp - dmg
    hero:animateAttack()
    if enemy.hp <= 0 then
      alert.time = 300
      alert.text = hero.name .. " attacks! It does " .. dmg .. " damage!\n" .. "You WIN!!!"
      alert:show()
      setState("win")
    else
      alert.time = 1.5
      alert.text = hero.name .. " attacks! It does " .. dmg .. " damage!\n" .. "They have " .. enemy.hp .. " hp left"
      alert:show()
      setState("idle")
      queueState("enemy", 2.5)
    end
  elseif action == "Defend" then
    alert.time = 2.5
    alert.text = hero.name .. " braces for impact!"
    defenseFactor = 0.5
    attackFactor = 2
    alert:show()
    setState("idle")
    queueState("enemy", 2.75)
  elseif action == "Nerd Out" then
    soundEffect("boing.mp3")
    defenseFactor = 2
    if math.random() > .8 then
      attackFactor = 4
    end
    alert.time = 2.5
    alert.text = hero.name .. " Nerds Out!!\nIt's pretty sick but " .. enemy.name .. " isn't impressed :("
    alert:show()
    setState("idle")
    queueState("enemy", 2.75)
  end
end

function OnEnemyAction(action)
  if action == "Attack" then
    soundEffect("17_orc_atk_sword_1")
    local dmg = math.floor(math.random() * 10 * defenseFactor)
    defenseFactor = 1
    hero.hp = hero.hp - dmg
    -- enemy:animateAttack()

    if hero.hp <= 0 then
      alert.time = 300
      alert.text = enemy.name .. " attacks! It does " .. dmg .. " damage!\n" .. "LOL, you DIED!!!"
      alert:show()
      setState("lose")
    else
      alert.time = 2
      alert.text = enemy.name .. " attacks! It does " .. dmg .. " damage!\n" .. "You have " .. hero.hp .. " hp left"
      alert:show()
      setState("idle")
      queueState("player", 2.5)
    end

  end
end
