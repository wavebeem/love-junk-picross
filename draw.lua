draw = {}

local function rectangle(opts)
    local x = assert(opts.x)
    local y = assert(opts.y)
    local w = assert(opts.w)
    local h = assert(opts.h)
    local color = assert(opts.color)

    local alpha = opts.outlineAlpha or 255

    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, w, h)

    if opts.outline then
        local line = opts.outlineWidth or 1
        --love.graphics.setColor(colors.cursor)
        --love.graphics.setLineWidth(line)
        --love.graphics.setLineStyle("rough")

        local shadow = {0, 0, 0, 32}

        if line <3 then
        love.graphics.setColor(opts.outlineColor or shadow)
        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(color)
        love.graphics.rectangle("fill",
            x +   line, y +   line,
            w - 2*line, h - 2*line)
        else
            love.graphics.setColor({0, 0, 0, 255})
            love.graphics.rectangle("fill", x, y, w, h)
            love.graphics.setColor(opts.outlineColor or shadow)
            love.graphics.rectangle("fill",
                x + 1, y + 1,
                w - 2, h - 2)
            love.graphics.setColor({0, 0, 0, 255})
            love.graphics.rectangle("fill",
                x +   line, y +   line,
                w - 2*line, h - 2*line)
            love.graphics.setColor(color)
            line = line + 1
            love.graphics.rectangle("fill",
                x +   line, y +   line,
                w - 2*line, h - 2*line)
        end

        --love.graphics.rectangle("line", x + 0.5, y + 0.5, w - 1, h - 1)
    end
end

draw.rectangle = rectangle
