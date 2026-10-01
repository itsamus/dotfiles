local M = {}
local detect_comment = require("core.detect_comment")

function M.addTitle()
  vim.ui.input({ prompt = 'Title:// ' }, function(input)
    if not input or input == '' then return end

    local cstring = detect_comment.addComment() or "-- %s"

    local prefix = cstring:gsub("%%s.*", "")
    local suffix = cstring:gsub("^.-%%s", "")

    local stripped_prefix = prefix:match("^%s*(.-)%s*$")
    if stripped_prefix:len() == 1 then
      prefix = stripped_prefix .. stripped_prefix
    end

    if not prefix:match("%s$") and prefix ~= "" then
      prefix = prefix .. " "
    end
    prefix = prefix:match("^%s*(.-)$")

    local lengte = vim.fn.strdisplaywidth(input)
    local lijn = string.rep('─', lengte + 1)

    local vaste_lengte = vim.fn.strdisplaywidth(prefix) + vim.fn.strdisplaywidth(lijn) + 1 + vim.fn.strdisplaywidth(suffix)
    local extra_streepjes = math.max(0, 80 - vaste_lengte)
    local laatste_deel = string.rep('─', extra_streepjes)

    local template = {
      string.format('%s%s╮%s', prefix, lijn, suffix),
      string.format('%s%s │%s', prefix, input, suffix),
      string.format('%s%s┴%s%s', prefix, lijn, laatste_deel, suffix),
    }

    local huidige_rij = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_lines(0, huidige_rij, huidige_rij + 1, false, template)
  end)
end

return M

-- ─────╮
-- bash │
--
-- ─────────────────────────────────────────────────────────────────────────────
-- ────╮
-- lua │
-- ────┴────────────────────────────────────────────────────────────────────────
