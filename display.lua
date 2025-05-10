local camera = require("camera")
local countries = require("data/countries")
local regions = require("data/regions")
local player = require("player")
local organizations = require("data/organizations")

local display = {}

fps = 0
fps_display = 0
fps_timer = love.timer.getTime()
font = love.graphics.newFont("data/fonts/PT_Sans/PTSans-Regular.ttf", 16)
love.graphics.setDefaultFilter("nearest")
sputnik = love.graphics.newImage("data/sputnik_map.png")

function display.region_color(region_id)
    local color = {region={}, border={}}

    color.region = {r=180, g=180, b=180}
    color.border = {r=100, g=100, b=100}

    if player.settings_values.map_mode[player.settings.map_mode] == "organizations" then
        local in_org = false

        if regions[region_id].country ~= nil then
            for i, org in ipairs(countries[regions[region_id].country].organizations) do
                if org == organizations[player.display_organization].id then
                    color.region = {r=0, g=0, b=255}
                end
            end
        end
        
    elseif regions[region_id].country ~= nil then
        color.region = countries[regions[region_id].country].color
        color.border = countries[regions[region_id].country].border_color
    end

    return color
end

function display.fps()
    love.graphics.print(fps_display, font, 10, 10)

    if fps_timer + 1 < love.timer.getTime() then
        fps_display = fps
        fps = 0
        fps_timer = love.timer.getTime()
    else
        fps = fps + 1
    end
end

function display.debug()
    love.graphics.print("display regions: ".. player.settings_values.map_mode[player.settings.map_mode], font, 10, 26)
    love.graphics.print("display organization: ".. organizations[player.display_organization].id, font, 10, 42)
    love.graphics.print("zoom: ".. camera.zoom, font, 10, 58)
end

function display.regions()
    for i = 1, #regions do
        if #regions[i].points > 2 then
            local coords = {}
            for n = 1, #regions[i].points do
                -- print("region " .. i - 1 .. " / point " .. n - 1)
                coords[#coords+1] = regions[i].points[n].x * camera.zoom - camera.x
                coords[#coords+1] = regions[i].points[n].y * camera.zoom - camera.y
            end

            local triangles = love.math.triangulate(coords)

            local color = display.region_color(i)

            love.graphics.setColor(color.region.r / 255, color.region.g / 255, color.region.b / 255, camera.transparency)

            for i, triangle in ipairs(triangles) do
                love.graphics.polygon("fill", triangle)
            end

            love.graphics.setColor(color.border.r / 255, color.border.g / 255, color.border.b / 255, 0.2)
            love.graphics.setLineWidth(0.5 * camera.zoom)

            love.graphics.polygon("line", coords)

            love.graphics.setColor(1, 1, 1)

            love.graphics.print(i, font, regions[i].center.x * camera.zoom - camera.x, regions[i].center.y * camera.zoom - camera.y)
        end
    end
end

function display.all()
    --love.graphics.clear(0.45, 0.75, 0.9)
    love.graphics.draw(sputnik, 0-camera.x, 0-camera.y, 0, camera.zoom / 2)
    display.regions()
    display.fps()
    display.debug()
end

return display