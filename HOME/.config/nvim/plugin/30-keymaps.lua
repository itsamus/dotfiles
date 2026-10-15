-- ────────╮
-- KEYMAPS │
-- ────────┴────────────────────────────────────────────────────────────────────
-- Table of Contents

-- 0.0   VARS
-- 0.0.1 Remap Normal Mode
-- 0.0.2 Remap Insert Mode
-- 0.0.3 Remap Visual Mode
-- 0.0.4 Remap Command Mode

-- ─────────────────────────────────────────────────────────────────────────────
-- 0.0.1 Remap Normal Mode

local nmap = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 0.0.2 Remap Insert Mode

local imap = function(lhs, rhs, desc)
	vim.keymap.set("i", lhs, rhs, { desc = desc })
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 0.0.3 Remap Visual Mode

local vmap = function(lhs, rhs, desc)
	vim.keymap.set("v", lhs, rhs, { desc = desc })
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 0.0.4 Remap Command Mode

local cmap = function(lhs, rhs, desc)
	vim.keymap.set("c", lhs, rhs, { desc = desc })
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. Leader Clues

Config.leader_group_clues = {
	{ mode = "n", keys = "<Leader>0", desc = "+File_Layout" },
	{ mode = "n", keys = "<Leader>f", desc = "+Find" },
}
local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end
local new_scratch_buffer = function()
	vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

-- ─────────────────────────────────────────────────────────────────────────────
-- File_Layout

-- -- Insert title
---@module 'fileLayout.title'
local function title()
	require("fileLayout.title").addTitle()
end
nmap_leader("00", title, "insert title")

-- -- Insert Seperator
local separator = require("fileLayout.seperator")
vim.api.nvim_create_user_command("InsertSeperator", function()
	separator.insert()
end, {})
nmap_leader("01", ":InsertSeperator<CR>", "insert seperator")
nmap_leader("/", ":nohlsearch<CR>", "Clear search highlight")

-- ─────────────────────────────────────────────────────────────────────────────
-- XMAP_LEADER

-- ─────────────────────────────────────────────────────────────────────────────
-- -- -- Other Normal Mappings

-- -- -- Don't skip wrapped linen while scrolling.
nmap("<Down>", "gj")
nmap("<Up>", "gk")

-- -- -- Keybond to resize the windowns
nmap("<C-Up>", ":resize +2<CR>")
nmap("<C-Down>", ":resize -2<CR>")
nmap("<C-Left>", ":vertical resize -2<CR>")
nmap("<C-Right>", ":vertical resize +2<CR>")

-- -- -- insert a dynamic colorcolumn
nmap("cc", require("core.colorcolumn").cycle)

-- -- -- Quickly surround a word in " or '
vim.keymap.set("n", "<leader>'", "ysiw'", { remap = true })
vim.keymap.set("n", '<leader>"', 'ysiw"', { remap = true })

-- -- -- Pull out my TODO file
vim.keymap.set("n", "<leader>P", "<cmd>e ~/.config/nvim/todo.md<CR>")

-- nmap("<leader>L", function()
-- 	if vim.opt.spelllang:get()[1] == "en" then
-- 		-- Schakel over naar Nederlands
-- 		vim.opt.spelllang = "nl"
-- 		vim.opt.dictionary = "/usr/share/dict/dutch"
-- 		vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/nl.utf-8.add"
-- 		print("Spelling & Dictionary gewijzigd naar: Nederlands")
-- 	else
-- 		-- Schakel terug naar Engels
-- 		vim.opt.spelllang = "en"
-- 		vim.opt.dictionary = "/usr/share/dict/american-english-insane"
-- 		vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
-- 		print("Spelling & Dictionary gewijzigd naar: Engels")
-- 	end
-- end, "Toggle taal (EN/NL) voor spelling en dictionary")

-- ─────────────────────────────────────────────────────────────────────────────
-- -- -- Visual Mode MAppings

-- -- -- Move selected lines up and down
vmap("<A-Up>", ":m '<-2<CR>gv=gv")
vmap("<A-Down>", ":m '>+1<CR>gv=gv")

-- -- -- Indent selected lines left and right
vmap("<", "<gv")
vmap(">", ">gv")

-- ─────────────────────────────────────────────────────────────────────────────
-- -- -- Command Mode Mappings

-- -- -- Sometimes I make a typo...
cmap("Wq", "wq")
cmap("Q", "q")

-- -- -- Quickly show command history
cmap("<Up>", function()
	if vim.fn.getcmdtype() == ":" then
		vim.schedule(function()
			require("telescope.builtin").command_history({
				results_title = "Command History",
				prompt_title = "",
				selection_caret = " ",
				attach_mappings = function(prompt_bufnr, map)
					local action_state = require("telescope.actions.state")
					local actions = require("telescope.actions")

					-- Overschrijf de default actie (Enter)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)

						if selection then
							-- Zet het commando op de command-line zonder het direct uit te voeren
							vim.fn.feedkeys(":" .. selection[1], "n")
						end
					end)

					return true
				end,
			})
		end)
		return "<C-c>"
	else
		return "<Up>"
	end
end, "Open Telescope command history")

-- ─────────────────────────────────────────────────────────────────────────────
