require "parse"

local puzzle
local metadata

function love.load()
    puzzle = parse.loadPuzzle("puzzles/test.txt")
    metadata = puzzle.title .. " by " .. puzzle.author

    love.graphics.setCaption(metadata)
end

function love.draw()
    local x, y = 0, 0
    local size = 50

    for r = 1, puzzle.size.rows do
        for c = 1, puzzle.size.cols do
            if puzzle.get(r, c) == "#" then
                love.graphics.rectangle("fill", x, y, size, size)
            else
                love.graphics.rectangle("line", x, y, size, size)
            end
            x = x + size
        end
        y = y + size
        x = 0
    end

    love.graphics.print(metadata, x, y)
end

function love.keypressed(key, unicode)
    if key == "escape" or key == "q" then
        love.event.quit()
    end
end
