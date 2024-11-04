ManagerArrangment = Object:extend()
require "manager_knuckles"

function ManagerArrangment:new(managerKnucle, deckSize)
  self.managerKnucle           = managerKnucle
  self.decksize                = deckSize

  self.handsPositions          = {}
  self.handsPositions.x     = {}
  self.handsPositions.y     = {}
  --self.handsPositions.step     = 70
  -- размер поля для розданых карт
  self.placeHandDeck           = {}
  self.placeHandDeck.size      = 800
  self.placeHandDeck.startPosx = 200
  self.placeHandDeck.startPosy = 500

  self.speed                   = 1
  self.move                    = true
  self.paddingLeftX            = 10
  self.placeBackSideDeck       = {}
  self.placeBackSideDeck.x     = 100
  self.placeBackSideDeck.y     = 500
  self.backsideIsDraw          = false
  self.deckHandIsDraw          = false
end

function ManagerArrangment:setPositionFor(knucle, x, y)
  knucle.x = x
  knucle.y = y
end

function ManagerArrangment:activeObject(x, y)
  -- когда будут известны все зоны можно искать только в элеметах этой зоны
  local deck = self.managerKnucle:getHandDeck()
  for i = 1, #deck do
    if (x > deck[i].x and x < deck[i].x + deck[i].width) 
     and ( y > deck[i].y and y < deck[i].y + deck[i].height) then
      deck[i]:select()
     end

  end


end

function ManagerArrangment:firstDealing(dt)
  local hand = self.managerKnucle:getHandDeck()
  if #hand ~= self.decksize then
    print("не совпадают размеры колоды и руки")
  end

  if (self.move) then
    for i = 1, #self.handsPositions.x do

      if hand[i].isMove then

      local dx = self.handsPositions.x[i] - hand[i].x
      local dy = self.handsPositions.y[i] - hand[i].y

      if math.abs(dx) < 1 and math.abs(dy) < 1 then
        hand[i].isMove = false
      else
        local speed = 200 * dt
        hand[i].x = hand[i].x + math.max(-speed, math.min(speed, dx))
        hand[i].y = hand[i].y + math.max(-speed, math.min(speed, dy))

        -- Увеличиваем угол вращения
        -- card.angle = card.angle + 5 * dt -- Измените 5 на любое значение для изменения скорости вращения
      end
      end
    end
  end
end

function ManagerArrangment:drawHandDeck()
  --отрисовываем руку
  for i = 1, #self.managerKnucle:getHandDeck() do
    self.managerKnucle:getHandDeck()[i]:draw(DefaultColorKnucle)
  end
  end

function ManagerArrangment:drawBacksideDeck()
  --if not self.backsideIsDraw then
  local bs = self.managerKnucle:getBackside()
  print(bs == nil)
  self:setPositionFor(bs, self.placeBackSideDeck.x, self.placeBackSideDeck.y)
  bs:draw(DefaultColorBackside)
  self.backsideIsDraw = true
  -- end
end

function ManagerArrangment:initialize()
  print("ManagerArrangment init")
  -- расчитываем позиции руки с картами
  self:calculatePositionsForHandDeck(self.decksize)
  -- помещаем случаные карты в руку
  self.managerKnucle:getKnucles(self.decksize)
end

function ManagerArrangment:calculatePositionsForHandDeck(qauntity)
  local sizeKnucles = SizeKnuckle
  local totalSize = qauntity * sizeKnucles[1]
  local remainigSpace = self.placeHandDeck.size - totalSize
  --количество промежутков
  local gaps = qauntity - 1
  local distance = gaps > 0 and remainigSpace / gaps or 0
  --определяем позиции
  local curentPosx = self.placeHandDeck.startPosx
  local curentPosy = self.placeHandDeck.startPosy
  for i = 1, qauntity do
    self.handsPositions.x[i] = curentPosx
    self.handsPositions.y[i] = curentPosy
    print( self.handsPositions.x[i])
    print( self.handsPositions.y[i])
    curentPosx = curentPosx + sizeKnucles[1] + distance
    
  end
end
