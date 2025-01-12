ManagerKnuckles = Object:extend()
require "knuckle"

--создает колоду.
--карты
--руку с картами
function ManagerKnuckles:new()
  self.deck        = {}
  self.usedNumbers = {}
  self.handDeck    = {}
  self.bakside = nil
end

function ManagerKnuckles:initialize()
self:createDeck()
self:createBackSide()
end

-- добавляет карты в коколоду
function ManagerKnuckles:addKnucklesToDeck(knucles)
  
end

function ManagerKnuckles:getKnucles(quantity)
  --[[  if #self.usedNumbers >= #self.deck then
        error("All numbers have been used.")
    end]]
  for i = 1, quantity do
    local number = self:getRandomNumber()
    local kn = self.deck[number]
    --print("kn:", kn.v1, kn.v2, 50)       -- Добавьте это для отладки
    self.handDeck[i] = kn
  end
end

function ManagerKnuckles:createDeck()
  local index = 1
  for i = 1, 6 do
    for j = 1, 6 do
      local value = { i, j }
      local kn = Knuckle(SizeKnuckle[1], SizeKnuckle[2], value, 4)
      self.deck[index] = kn
      -- print("Creating Knuckle at position:",kn.v1, kn.v2)
      index = index + 1
    end
  end
end

function ManagerKnuckles:createBackSide()
  print("create backside")
  self.bakside =  BackSide(SizeKnuckle[1], SizeKnuckle[2])
  print(self.bakside == nil)
end

function ManagerKnuckles:getBackside()
  return self.bakside
end

function ManagerKnuckles:getHandDeck()
  return self.handDeck
end

function ManagerKnuckles:getRandomNumber()
  number = nil
  condition = true
  while condition do
    number = love.math.random(1, #self.deck)
    condition = false
    for _, element in pairs(self.usedNumbers) do
      if element == number then
        condition = true
        break
      end
    end
  end
  table.insert(self.usedNumbers, number)

  return number
end
