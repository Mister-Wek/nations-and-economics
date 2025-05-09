local display = require("display")
local update = require("update")
local start = require("start")

regions = {}

function love.load()
    start.all()
end

function love.update(dt)
    update.all()
end

function love.draw()
    display.all()
end

function love.resize(w, h)

end