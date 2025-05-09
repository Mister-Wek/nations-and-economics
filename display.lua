local camera = require("camera")
local data = require("data")
local countries = require("data/countries")
local regions = require("data/regions")

local display = {}

fps = 0
fps_display = 0
fps_timer = love.timer.getTime()
font = love.graphics.newFont("data/fonts/PT_Sans/PTSans-Regular.ttf", 16)

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

function display.regions()
    for i = 1, #regions do
        if #regions[i].points > 2 then
            coords = {}
            for n = 1, #regions[i].points do
                coords[#coords+1] = regions[i].points[n].x * camera.zoom - camera.x
                coords[#coords+1] = regions[i].points[n].y * camera.zoom - camera.y
            end

            triangles = love.math.triangulate(coords)

            region_color = countries[regions[i].country].color
            love.graphics.setColor(region_color.r / 255, region_color.g / 255, region_color.b / 255)

            for i, triangle in ipairs(triangles) do
                love.graphics.polygon("fill", triangle)
            end

            border_color = countries[regions[i].country].border_color
            love.graphics.setColor(border_color.r / 255, border_color.g / 255, border_color.b / 255)
            love.graphics.setLineWidth(1 * camera.zoom)

            love.graphics.polygon("line", coords)

            love.graphics.setColor(1, 1, 1)

            love.graphics.print(i, font, regions[i].center.x * camera.zoom - camera.x, regions[i].center.y * camera.zoom - camera.y)
        end
    end
end

function display.all()
    display.regions()
    display.fps()
end

return display