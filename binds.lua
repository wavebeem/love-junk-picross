binds = {
    q       = love.event.quit,
    escape  = love.event.quit,
    alt_1   = function() print "ALT 1"  end,
    alt_2   = function() print "ALT 2"  end,
    meta_1  = function() print "META 1" end,
    meta_2  = function() print "META 2" end,
}

local function noop() end

local function default(k, v)
    return noop
end

setmetatable(binds, { __index = default })
