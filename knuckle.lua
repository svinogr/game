Knuckle = Object:extend()

 SizeKnuckle = {70, 90}
 DefaultColorKnucle = {39/255, 193/255, 211/255}

function Knuckle:new(width, height, value, radius)
self.x = 100
self.y = 500
self.width = width
self.height = height
self.v1 = value[1]
self.v2 = value[2]
self.radius = radius
self.targetX = 0
self.targetY = 0
self.isMove = true
self.isSelect = false
self.up = 0 
end

function Knuckle:select()
    print("selcet") 
    if  not self.isSelect then
        self.y = self.y - 10 
        self.isSelect = true
    else
        self.y = 500
        self.isSelect = false
     end
end

function Knuckle:draw(color)
love.graphics.setColor(color[1], color[2], color[3])

--love.graphics.setColor(39/255, 193/255, 211/255)

love.graphics.rectangle("fill", self.x , self.y , self.width, self.height)

love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
love.graphics.setColor(1,1,1)
love.graphics.line(self.x + 8, self.y + self.height/2, self.x + self.width -8, self.y + self.height/2)
love.graphics.setColor(1,1,1)

love.graphics.setColor(1,1,1)
self:drawPoints("up")
self:drawPoints("down")
self:drawShadows(color)
end	

function Knuckle:drawShadows(color)
love.graphics.setColor(0,0,0) 
local topXRight1 = self.x + self.width +1
local topYRight1 = self.y + 1
local topXRight2 = self.x + self.width + 2
local topYRight2 = self.y + 2

local bottomXRight1 = self.x + self.width +1
local bottomYRight1 = self.y + self.height + 1
local bottomXRight2 = self.x + self.width + 2
local bottomYRight2 = self.y + 2 + self.height

local bottomXLeft1 = self.x +1
local bottomYLeft1 = self.y + self.height +1
local bottomXLeft2 = self.x + 2
local bottomYLeft2 = self.y + 2 + self.height

love.graphics.line(topXRight1, topYRight1, topXRight2, topYRight2)
love.graphics.line(bottomXRight1, bottomYRight1, bottomXRight2, bottomYRight2)
love.graphics.line(topXRight1, topYRight1,bottomXRight1, bottomYRight1)
love.graphics.line(topXRight2, topYRight2, bottomXRight2, bottomYRight2)
love.graphics.line(bottomXLeft1, bottomYLeft1, bottomXLeft2, bottomYLeft2)

love.graphics.line(bottomXLeft1, bottomYLeft1, bottomXRight1, bottomYRight1)
love.graphics.line(bottomXLeft2, bottomYLeft2, bottomXRight2, bottomYRight2)

-- нижняя и боковая грань
local factor = 0.7
love.graphics.setColor(color[1] * factor, color[2]*factor, color[3]*factor)
local bottomXLeft1Gran = self.x
local bottomYLeft1Gran = self.y + self.height
local bottomXRight1Gran = self.x + self.width 
local bottomYRight1Gran = self.y + self.height
local topXRight1Gran = self.x + self.width
local topYRight1Gran = self.y
love.graphics.line(bottomXLeft1Gran, bottomYLeft1Gran, bottomXRight1Gran, bottomYRight1Gran)
love.graphics.line(topXRight1Gran, topYRight1Gran, bottomXRight1Gran, bottomYRight1Gran)
love.graphics.setColor(1,1,1)
end

function Knuckle:drawPoints(direction)
local bias = 0
local qauntity = self.v1

if direction == "down" then
	bias = self.height / 2
    qauntity = self.v2
end

if qauntity == 1 then
self:drawOnePoints(bias)
end

if qauntity == 2 then
self:drawTwoPoints(bias)
end

if qauntity == 3 then
self:drawThreePoints(bias)
end

if qauntity == 4 then
self:drawFourPoints(bias)
end	

if qauntity == 5 then
self:drawFivePoints(bias)
end
if qauntity == 6 then
self:drawSixPoints(bias)
end

end

function Knuckle:drawOnePoints(bias)
local c1 = self.x + self.width / 2  
local c2 = self.y  + self.height / self.radius + bias
love.graphics.circle("fill", c1, c2, self.radius)
end	

function Knuckle:drawTwoPoints(bias)
local c1 = self.x + self.radius * 3 
local c2 = self.y  + self.height / 4 + bias
love.graphics.circle("fill", c1, c2, self.radius)

local c1 = self.x +  self.width - self.radius * 3
local c2 = self.y  + self.height /4 + bias
love.graphics.circle("fill", c1, c2, self.radius) 
end	

function Knuckle:drawThreePoints(bias)
local c1 = self.x + self.radius * 3 
local c2 = self.y  + self.radius * 2 + bias
love.graphics.circle("fill", c1, c2, self.radius)

local c1 = self.x  + self.width - self.radius * 3  
local c2 = self.y  +  self.height/ 2  - self.radius * 2 + bias
love.graphics.circle("fill", c1, c2, self.radius)

self:drawOnePoints(bias)
end

function Knuckle:drawFourPoints(bias)
local c1 = self.x + self.radius * 3 
local c2 = self.y  + self.radius * 2 + bias

love.graphics.circle("fill", c1, c2, self.radius)
local c1 = self.x  + self.width - self.radius * 3  
local c2 = self.y  +  self.height/ 2  - self.radius * 2 + bias
love.graphics.circle("fill", c1, c2, self.radius)
 
local c1 = self.x + self.radius * 3  
local c2 = self.y  + self.height/2 - self.radius * 2 + bias
love.graphics.circle("fill", c1, c2, self.radius)

local c1 = self.x + self.width - self.radius * 3 
local c2 = self.y   +  self.radius * 2 + bias
love.graphics.circle("fill", c1, c2, self.radius)
end


function Knuckle:drawFivePoints(bias)
self:drawFourPoints(bias)
self:drawOnePoints(bias)
end

function Knuckle:drawSixPoints(bias)
self:drawFourPoints(bias)
self:drawTwoPoints(bias)
end

function Knuckle:Select(x, y)
self.x = x
self.y = y	
end