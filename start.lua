local regions = require("data/regions")
local data = require("data")
local countries = require("data/countries")

local start = {}

function start.all()
    love.window.setMode(800, 600, {["resizable"]=true})
    love.window.setTitle("Nations and Economics")
    love.window.setVSync(0)

    regions_image_data = love.image.newImageData('data/regions.png')
    regions_image = love.graphics.newImage(regions_image_data)
    regions_w = regions_image:getWidth()
    regions_h = regions_image:getHeight()

    for i = 1, #regions do
        regions[i].points = {}
        regions[i].color = {}
        regions[i].center = {}
    end
    for x = 0, regions_w - 1 do
        for y = 0, regions_h - 1 do
            local rf, gf, bf, af = regions_image_data:getPixel(x, y)
            if af ~= 0 then
                r, g, b, a = love.math.colorToBytes(rf, gf, bf, af)

                regions[b + 1].points[g + 1] = {["x"]=math.floor(x/2), ["y"]=math.floor(y/2)}
                regions[b + 1].center = regions[b + 1].points[1]
                regions[b + 1].color = {r=200, g=200, b=200}
            end
        end
    end

    for i = 1, #regions do
        if #regions[i].points > 2 then
            local x = 0
            local y = 0

            for ii, point in ipairs(regions[i].points) do
                x = x + point.x
                y = y + point.y
            end
            
            x = x / #regions[i].points
            y = y / #regions[i].points
            
            regions[i].center = {["x"]=x, ["y"]=y}
        end
    end

    for k, country in pairs(countries) do
        for n, region in ipairs(country.regions) do
            regions[n].country = k
        end
    end
end

return start