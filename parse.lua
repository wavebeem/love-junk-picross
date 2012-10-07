parse = {}

local function loadPuzzle(filename)
    local f = io.open(filename, "r")
    local cells = {}
    local info  = {}
    local lines = {}
    local line  = f:read()
    local doneReadingInfo = false
    while line do
        local char  = line:sub(1, 1)
        local empty = not not line:find("^%s*$")

        if not empty and char == "." or char == "#" then
            doneReadingInfo = true

            if info.title == nil then
                print("error: puzzle does not have a title!")
                table.foreach(info, print)
                os.exit(1)
            end
        end

        if not empty and not doneReadingInfo then
            local i, j, key, val = line:find("^%s*(%a+)%s*:%s*(.-)%s*$")
            if key and val
            then info[key:lower()] = val
            else print("bad line in map file: " .. line)
            end
        elseif not empty then
            table.insert(lines, line)
        end
        line = f:read()
    end
    local rows = #lines
    local cols
    for row = 1, rows do
        cols = #lines[row]
        if cols ~= rows then
            print("error: puzzle is not square! (" .. rows .. "x" .. cols .. ")")
            os.exit(1)
        end
        for col = 1, cols do
            local key = row .. "," .. col
            cells[key] = lines[row]:sub(col, col)
        end
    end

    local puzzle = {
        title  = info.title,
        author = info.author or "Unknown",
        size = {
            rows = rows,
            cols = cols
        },
        get = function(r, c)
            return cells[r .. "," .. c]
        end,
    }

    return puzzle
end

parse.loadPuzzle = loadPuzzle
