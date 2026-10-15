local M = {}

-- Zet een specifieke waarde
function M.set(col)
    vim.opt.colorcolumn = tostring(col)
end

-- Zet de colorcolumn uit
function M.disable()
    vim.opt.colorcolumn = ""
end

-- Cyclus door de opties: 80 -> 100 -> 120 -> uit -> 80
function M.cycle()
    local current = vim.o.colorcolumn
    if current == "" then
        M.set("80")
    elseif current == "80" then
        M.set("100")
    elseif current == "100" then
        M.set("120")
    else
        M.disable()
    end
end

return M
