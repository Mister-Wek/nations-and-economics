local camera = require("camera")

local update = {}

function update.keyboard()
    if love.keyboard.isDown('a') then
        camera.x = camera.x - 1
    end
    if love.keyboard.isDown('d') then
        camera.x = camera.x + 1
    end
    if love.keyboard.isDown('w') then
        camera.y = camera.y - 1
    end
    if love.keyboard.isDown('s') then
        camera.y = camera.y + 1
    end
end

function update.all()
    update.keyboard()
end

return update