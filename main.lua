require "parse"
require "binds"
require "colors"

local puzzle
local metadata

function love.load()
    puzzle = parse.loadPuzzle("puzzles/test.txt")
    metadata = puzzle.title .. " by " .. puzzle.author

    love.graphics.setCaption(metadata)
end

function love.draw()
    local mar  = 12
    local pad  = 3
    local x, y = mar + pad, mar + pad
    local size = 50

    love.graphics.setBackgroundColor(colors.bg)

    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    size = (sh - mar*2 - (puzzle.size.rows + 1)*pad) / (puzzle.size.rows);

    love.graphics.setColor(colors.border)
    love.graphics.rectangle("fill", mar, mar, sw - 2*mar, sh - 2*mar)

    for r = 1, puzzle.size.rows do
        for c = 1, puzzle.size.cols do
            local filled = puzzle.get(r, c) == "#"
            local color  = colors[filled and "selected" or "fg"]
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", x, y, size, size)
            x = x + size + pad
        end
        y = y + size + pad
        x = pad + mar
    end

    --love.graphics.setColor(colors.sel)
    --love.graphics.print(metadata, x, y)
end

function love.update(dt)
end

function love.keypressed(key, unicode)
    if love.keyboard.isDown("lalt")
    then key = "alt_" .. key
    end

    if love.keyboard.isDown("lmeta")
    then key = "meta_" .. key
    end

    print("key pressed: " ..  key)

    binds[key]()
end
