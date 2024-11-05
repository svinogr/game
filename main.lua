if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local gridSize = 20             -- Размер маленьких квадратов
local width, height = 1024, 768 -- Ширина и высота окна
local backgroundCanvas          -- Canvas для фона
function love.load()
    Object = require "classic"
    require "managerarrangment"
    require "manager_knuckles"
    require "backside"

    love.window.setTitle("Domino")
    love.window.setMode(width, height)
    -- Создаем Canvas для фона
    backgroundCanvas = love.graphics.newCanvas(width, height)
    -- Рисуем фон в Canvas
    love.graphics.setCanvas(backgroundCanvas)
    for x = 0, width, gridSize do
        for y = 0, height, gridSize do
            -- Генерация теплого цвета
            local r = math.random(200, 255) / 255
            local g = math.random(150, 200) / 255
            local b = math.random(100, 150) / 255
           -- love.graphics.setColor(r, g, b)
           love.graphics.setColor(255/255, 188/255, 43/255)
           love.graphics.rectangle("fill", x, y, gridSize, gridSize)
        end
    end
    love.graphics.setCanvas()    -- Возвращаемся к основному Canvas
    local mk = ManagerKnuckles()
    mk:initialize()
    managerArrangment = ManagerArrangment(mk, 5, ResetButton(100, 100))
    managerArrangment:initialize()
    x = 0
end

function love.update(dt)
    x = x + 5 * dt
    managerArrangment:firstDealing(dt)
end

function love.draw()
    -- Рисуем фон
    love.graphics.draw(backgroundCanvas, 0, 0)
    -- Рисуем игровое поле

   managerArrangment:draw()
end

function love.mousepressed(x, y, button)
    if (button == 1) then
        print(x, y)
        managerArrangment:clickButton1(x, y)
    end
end
