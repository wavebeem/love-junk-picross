cursor = {
    row = 1,
    col = 1,
}

binds = {
    q       = love.event.quit,
    escape  = love.event.quit,
    alt_1   = function() print "ALT 1"  end,
    alt_2   = function() print "ALT 2"  end,
    meta_1  = function() print "META 1" end,
    meta_2  = function() print "META 2" end,

    up    = function() cursor.row = cursor.row - 1 end,
    left  = function() cursor.col = cursor.col - 1 end,
    down  = function() cursor.row = cursor.row + 1 end,
    right = function() cursor.col = cursor.col + 1 end,
}

local function noop() end

local function default(k, v)
    return noop
end

setmetatable(binds, { __index = default })
