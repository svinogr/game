ManagerArrangment = Object:extend()
require "manager_knuckles"
require "managerButtons"

function ManagerArrangment:new(deckSize)
  self.decksize                = deckSize
 
  local mb =  ManagerButtons()
  self.managerButtons         = mb
 
  local mk = ManagerKnuckles()
  mk:initialize()
  self.managerKnucle           = mk

  self.handsPositions          = {}
  self.handsPositions.x        = {}
  self.handsPositions.y        = {}
  --self.handsPositions.step     = 70
  -- размер поля для розданых карт
  self.placeHandDeck           = {}
  self.placeHandDeck.size      = 500
  self.placeHandDeck.startPosx = 150
  self.placeHandDeck.startPosy = 500
  self.placeHandDeck.fon = {}
  self.placeHandDeck.fon.startx = 140
  self.placeHandDeck.fon.starty = 495
  self.placeHandDeck.fon.lenght = deckSize * 100 + 20
  self.placeHandDeck.fon.height = 110

  self.placeButtons = {}
  self.placeButtons.fon = {}
  self.placeButtons.fon.startx = 690
  self.placeButtons.fon.starty = 495
  self.placeButtons.fon.lenght = 100
  self.placeButtons.fon.height = 150

  self.speed                   = 1
  self.move                    = true
  self.paddingLeftX            = 10
  self.placeBackSideDeck       = {}
  self.placeBackSideDeck.x     = 10
  self.placeBackSideDeck.y     = 500
  self.backsideIsDraw          = false
  self.deckHandIsDraw          = false
end

function ManagerArrangment:setPositionFor(knucle, x, y)
  knucle.x = x
  knucle.y = y
end

function ManagerArrangment:clickButton1(x, y)
  -- когда будут известны все зоны можно искать только в элеметах этой зоны
  
  if self:isPlaceButtons(x, y) then
    self.managerButtons:clickButton(x, y, 1)
    do return end
  end

  if self:isPlaceDeckHand(x, y) then
    -- переписать как выше через менеджер
    local deck = self.managerKnucle:getHandDeck()
    for i = 1, #deck do
      if (deck[i]:isMouseOver(x, y)) then
        deck[i]:select()
            end
    end
    do return end
  end 
  
 
end

function ManagerArrangment:isPlaceButtons(x, y)
  print("isPlaceButtons")
  return x > self.placeButtons.fon.startx and y > self.placeButtons.fon.starty 
  and x < self.placeButtons.fon.startx + self.placeButtons.fon.lenght
  and y < self.placeButtons.fon.starty + self.placeButtons.fon.height 
  
end

function ManagerArrangment:isPlaceDeckHand(x, y)
  print("isPlaceDeckHand")
  return  x > self.placeHandDeck.fon.startx and y > self.placeHandDeck.fon.starty 
            and x < self.placeHandDeck.fon.startx + self.placeHandDeck.fon.lenght
            and y < self.placeHandDeck.fon.starty + self.placeHandDeck.fon.height 
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

function ManagerArrangment:draw()
  self:drawButtons()
  self:drawHandDeck()
  self:drawBacksideDeck()
end

function ManagerArrangment:drawButtons()
  love.graphics.setColor(255 / 255, 145 / 255, 43 / 255)
  love.graphics.rectangle("fill", self.placeButtons.fon.startx, self.placeButtons.fon.starty, self.placeButtons.fon.lenght, self.placeButtons.fon.height)
  local res = self.managerButtons:getResetButton()
  local ste = self.managerButtons:getStepButton()
  self:setPositionFor(res, 700, 500)
  res:draw()
  self:setPositionFor(ste, 700, 550)
  ste:draw()
end

function ManagerArrangment:drawHandDeck()
  love.graphics.setColor(255 / 255, 145 / 255, 43 / 255)

  love.graphics.rectangle("fill", 
  self.placeHandDeck.fon.startx,self.placeHandDeck.fon.starty,self.placeHandDeck.fon.lenght,self.placeHandDeck.fon.height)
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
    print(self.handsPositions.x[i])
    print(self.handsPositions.y[i])
    curentPosx = curentPosx + sizeKnucles[1] + distance
  end
end
