-- ────────────────────────╮
-- autocommands for neovim │
-- ────────────────────────┴────────────────────────────────────────────────────
-- Table of Contents

-- 1. Restore last cursor position when reopening a file
-- 2. Highlight the yanked text for 500ms

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. Restore last cursor position when reopening a file

Config.new_autocmd("BufReadPost", "*", function()
	local mark = vim.api.nvim_buf_get_mark(0, '"')
	local lcount = vim.api.nvim_buf_line_count(0)
	if mark[1] > 0 and mark[1] <= lcount then
		pcall(vim.api.nvim_win_set_cursor, 0, mark)
	end
end, "Herstel cursorpositie bij openen")

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Highlight the yanked text for 500ms

Config.new_autocmd("TextYankPost", "*", function()
	vim.hl.on_yank({
		higroup = "IncSearch",
		timeout = 500,
	})
end, "Highlight tekst bij het yanken")

-- ─────────────────────────────────────────────────────────────────────────────

-- When you open a file and don’t have write permissions,
-- you can call :w!! and it will auto sudo the file for you.
-- Saves me practically every time I edit a system file. Sandwich reference
vim.cmd('ca w!! w !sudo tee >/dev/null "%"')
