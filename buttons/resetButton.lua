ResetButton = Object:extend()
SizeResetButton = {70, 90}
DefaultColorResetButton = {39/255, 193/255, 211/255}

function ResetButton:new(x, y)
self.x = x
self.y = y
end


function ResetButton:draw()
love.graphics.circle("fill", self.x , self.y ,  SizeResetButton[1])
end