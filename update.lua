local camera = require("camera")
local player = require("player")

local update = {}

function love.wheelmoved(x, y)
    if y > 0 then
        camera.zoom = camera.zoom + 0.1
    elseif y < 0 then
        camera.zoom = camera.zoom - 0.1
    end
end

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

    if love.keyboard.isDown('n') then
        player.display_organization = 1
        player.settings.map_mode = 2
    end
    if love.keyboard.isDown('b') then
        player.display_organization = 2
        player.settings.map_mode = 2
    end
    if love.keyboard.isDown('z') then
        player.settings.map_mode = 1
    end
end

function update.transparency()
    if camera.zoom < 4 then
        camera.transparency = 1
    else
        if camera.zoom < 6 then
            camera.transparency = 1 - (camera.zoom - 4) / 6
        else
            camera.transparency = 0.5
        end
    end
end

function update.all()
    update.keyboard()
    update.transparency()
end

return update