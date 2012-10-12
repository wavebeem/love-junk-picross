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
        love.graphics.setColor({0, 0, 0, alpha})
        love.graphics.setLineWidth(line)
        love.graphics.setLineStyle("rough")

        love.graphics.rectangle("fill", x, y, w, h)
        love.graphics.setColor(color)
        love.graphics.rectangle("fill",
            x +   line, y +   line,
            w - 2*line, h - 2*line)

        --love.graphics.rectangle("line", x, y, w, h)

        --love.graphics.rectangle("line", x + 1, y + 1, w - 1, h - 1)
    end
end

draw.rectangle = rectangle
