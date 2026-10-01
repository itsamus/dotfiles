local M = {}

-- Functie om te controleren of een regel meer dan 30 '─' tekens bevat
local function is_separator(line)
    if not line then
        return false
    end
    local count = 0
    for _ in line:gmatch("─") do
        count = count + 1
    end
    return count > 30
end

-- Zoek de regel waar het Table of Contents blok eindigt (de eerste separator na "Table of Contents")
local function find_toc_end(bufnr)
    bufnr = bufnr or 0
    if vim.b[bufnr].toc_end_lnum then
        return vim.b[bufnr].toc_end_lnum
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local found_toc = false
    for i, line in ipairs(lines) do
        if line:find("Table of Contents") then
            found_toc = true
        end
        if found_toc and is_separator(line) then
            vim.b[bufnr].toc_end_lnum = i
            return i
        end
    end
    return nil
end

-- Fold expression functie voor Neovim
function M.foldexpr()
    local lnum = vim.v.lnum
    local bufnr = vim.api.nvim_get_current_buf()
    local toc_end = find_toc_end(bufnr)

    -- 1. Negeer de Table of Contents en alles daarboven (geen folds)
    if toc_end and lnum <= toc_end then
        return "0"
    end

    local line = vim.fn.getline(lnum)

    -- 2. Also we een scheidingslijn (> 30 "─") tegenkomen, eindigt de huidige fold
    if is_separator(line) then
        return "<1"
    end

    -- 3. Zoek naar het startpatroon: [0-9].[A-Za-z] (bijv. "1.a" of "1. text")
    -- `%d` = cijfer, `%.` = punt, `%a` = letter
    if line:match("%d%..*%a") or line:match("%d%.%s*%a") then
        return ">1"
    end

    return "="
end

-- Configuratie functie om foldmethod in te stellen
function M.setup(opts)
    opts = opts or {}
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.require('toc_fold').foldexpr()"
end

return M
