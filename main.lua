require "parse"
require "binds"
require "colors"
require "draw"

local puzzle
local metadata

function love.load()
    puzzle = parse.loadPuzzle("puzzles/test.txt")
    metadata = puzzle.title .. " by " .. puzzle.author

    love.graphics.setCaption(metadata)
end

function love.draw()
    local mar  = 12
    local pad  = 1
    local x, y = mar + pad, mar + pad
    local size = 0

    love.graphics.setBackgroundColor(colors.bg)

    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    size = (sh - mar*2 - (puzzle.size.rows + 1)*pad) / (puzzle.size.rows);
    size = math.ceil(size)
    --size = 64
    --size = 32
    size = 24
    --size = 16

    --love.graphics.setColor(colors.border)
    --love.graphics.rectangle("fill", mar, mar, sw - 2*mar, sh - 2*mar)
    draw.rectangle {
        x = mar - pad,
        y = mar - pad,
        w = sw - 2*mar + 2*pad,
        h = sh - 2*mar + 2*pad,
        color = colors.border,
        outline = true,
        outlineColor = colors.outline,
    }

    for r = 1, puzzle.size.rows do
        for c = 1, puzzle.size.cols do
            local filled = puzzle.get(r, c) == "#"
            local color  = colors[filled and "selected" or "fg"]
            --love.graphics.setColor(color)
            --love.graphics.rectangle("fill", x, y, size, size)
            local isFocused = cursor.row == r and cursor.col == c
            draw.rectangle {
                x = x,
                y = y,
                w = size,
                h = size,
                color = color,
                outline = true,
                outlineWidth = isFocused and (size < 32 and 3 or 6) or 1,
                outlineColor = colors[isFocused and "cursor" or (filled and "outline" or "edge")],
            }
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

local function decoratedKey(modifier, key)
    local lmod = "l" .. modifier
    local rmod = "r" .. modifier
    local down = love.keyboard.isDown
    local pressed = down(lmod)  or down(rmod)
    local same    = key == lmod or key == rmod
    local modkey  = modifier .. "_" .. key

    if pressed and not same
    then return modkey
    else return key
    end
end

function love.keypressed(key, unicode)
    key = decoratedKey("alt",   key)
    key = decoratedKey("meta",  key)
    key = decoratedKey("super", key)

    print("key pressed: " ..  key)

    binds[key]()
end
