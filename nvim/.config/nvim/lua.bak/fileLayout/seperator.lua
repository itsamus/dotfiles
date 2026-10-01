local detector = require("core.detect_colorcolumn")
local detect_comment = require("core.detect_comment")
local M = {}

--- Bepaalt de totale lengte op basis van de colorcolumn waarde
local function get_length()
  local val = detector.get(0)
  if val == 2 then
    return 100
  elseif val == 3 then
    return 120
  else
    return 80 -- Standaard voor waarde 1 (uit of 80)
  end
end

--- Voegt de separator in als commentaar op de huidige cursorregel
function M.insert()
  local target_length = get_length()
  local cs_template = detect_comment.addComment()

  -- Haal de linker- en rechterkant op uit de commentstring (bijv. "##" en "")
  local left, right = cs_template:match("(.*)%%s(.*)")
  left = left and vim.trim(left) or ""
  right = right and vim.trim(right) or ""

  local prefix = left ~= "" and (left .. " ") or ""
  local suffix = right ~= "" and (" " .. right) or ""

  -- Bereken hoeveel '─' karakters er nodig zijn om exact op target_length uit te komen
  local fixed_len = vim.fn.strchars(prefix) + vim.fn.strchars(suffix)
  local repeat_len = target_length - fixed_len
  if repeat_len < 10 then
    repeat_len = 40
  end

  local separator_line = prefix .. string.rep("─", repeat_len) .. suffix

  -- Plaats de regel in de buffer
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row, false, { separator_line })
end

return M
