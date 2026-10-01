local M = {}

local buf = vim.api.nvim_create_buf(false, true)

-- Bepaal de afmetingen (1/3e van het scherm)
local width = math.floor(vim.o.columns / 3)
local height = math.floor(vim.o.lines / 3)

local text = "enable LSP;"

-- 1. Horizontaal centreren (spaties ervoor berekenen)
local padding_left = math.max(0, math.floor((width - vim.fn.strdisplaywidth(text)) / 2))
local centered_text = string.rep(" ", padding_left) .. text

-- 2. Plaats de tekst op de tweede regel (i == 2)
local lines = {}
for i = 1, height do
	if i == 3 then
		table.insert(lines, centered_text)
	else
		table.insert(lines, "")
	end
end

-- Vul de buffer met de regels
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

-- Bereken het midden van het scherm voor het venster zelf
local row = math.floor((vim.o.lines - height) / 2)
local col = math.floor((vim.o.columns - width) / 2)

-- Open het floating window
vim.api.nvim_open_win(buf, true, {
	relative = "editor",
	width = width,
	height = height,
	row = row,
	col = col,
	style = "minimal",
	border = "rounded",
	title = " 1/3 Schermgrootte ",
	title_pos = "center",
})

return M
