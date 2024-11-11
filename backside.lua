BackSide = Object:extend()
DefaultColorBackside = {57/255, 98/255, 218/255}

function BackSide:new(width, height)
self.x = 100
self.y = 500
self.width = width
self.height = height
end

function BackSide:draw(color)
love.graphics.setColor(color[1], color[2], color[3])
love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
love.graphics.setColor(1,1,1)
love.graphics.line(self.x + 8, self.y + self.height/2 + 8, self.x + self.width -8, self.y + self.height/2 + 8)
love.graphics.line(self.x + 8, self.y + self.height/2 + 16,self.x + self.width -8, self.y + self.height/2 + 16)
love.graphics.line(self.x + 8, self.y + self.height/2, self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2 - 8, self.x + self.width -8, self.y + self.height/2 - 8)
love.graphics.line(self.x + 8, self.y + self.height/2 -16, self.x + self.width -8, self.y + self.height/2 - 16)

love.graphics.line(self.x + 8, self.y + self.height/2 , self.x + self.width -8, self.y + self.height/2 + 8)
love.graphics.line(self.x + 8, self.y + self.height/2 ,self.x + self.width -8, self.y + self.height/2 + 16)
love.graphics.line(self.x + 8, self.y + self.height/2, self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2 , self.x + self.width -8, self.y + self.height/2 - 8)
love.graphics.line(self.x + 8, self.y + self.height/2 , self.x + self.width -8, self.y + self.height/2 - 16)

love.graphics.line(self.x + 8, self.y + self.height/2 + 8, self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2 + 16,self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2, self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2 - 8, self.x + self.width -8, self.y + self.height/2)
love.graphics.line(self.x + 8, self.y + self.height/2 -16, self.x + self.width -8, self.y + self.height/2)

self:drawShadows(color)
end	

function BackSide:drawShadows(color)
love.graphics.setColor(0,0,0) 
local factor = 0.7    
local topXRight1 = self.x + self.width +1
local topYRight1 = self.y + 1
local topXRight2 = self.x + self.width + 2
local topYRight2 = self.y + 2

local bottomXRight1 = self.x + self.width +1
local bottomYRight1 = self.y + self.height + 1
local bottomXRight2 = self.x + self.width + 2
local bottomYRight2 = self.y + self.height + 2

local bottomXLeft1 = self.x +1
local bottomYLeft1 = self.y + self.height + 1
local bottomXLeft2 = self.x + 2
local bottomYLeft2 = self.y + self.height + 2

love.graphics.line(topXRight1, topYRight1, topXRight2, topYRight2)
love.graphics.line(bottomXRight1, bottomYRight1, bottomXRight2, bottomYRight2)
love.graphics.line(topXRight1, topYRight1,bottomXRight1, bottomYRight1)
love.graphics.line(topXRight2, topYRight2, bottomXRight2, bottomYRight2)
love.graphics.line(bottomXLeft1, bottomYLeft1, bottomXLeft2, bottomYLeft2)

love.graphics.line(bottomXLeft1, bottomYLeft1, bottomXRight1, bottomYRight1)
love.graphics.line(bottomXLeft2, bottomYLeft2, bottomXRight2, bottomYRight2)

-- нижняя и боковая грань
love.graphics.setColor(color[1] * factor, color[2]*factor, color[3]*factor)
local bottomXLeft1Gran = self.x
local bottomYLeft1Gran = self.y + self.height
local bottomXRight1Gran = self.x + self.width 
local bottomYRight1Gran = self.y + self.height
local topXRight1Gran = self.x + self.width
local topYRight1Gran = self.y
--love.graphics.line(bottomXLeft1Gran.x, bottomYLeft1Gran, bottomXRight1Gran, bottomYRight1Gran)
love.graphics.line(topXRight1Gran, topYRight1Gran, bottomXRight1Gran, bottomYRight1Gran)
love.graphics.setColor(1,1,1)
end