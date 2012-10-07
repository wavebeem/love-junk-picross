require "parse"

local puzzle = parse.loadPuzzle("puzzles/test.txt")
print("title:",  "'" .. puzzle.title  .. "'")
print("author:", "'" .. puzzle.author .. "'")
for r = 1, puzzle.size.rows do
    for c = 1, puzzle.size.cols do
        local char = puzzle.get(r, c)
        io.write(char, " ")
    end
    io.write("\n")
end
