-- ────────╮
-- KEYMAPS │
-- ────────┴────────────────────────────────────────────────────────────────────
-- Table of Contents

-- 0.0   VARS
-- 0.0.1 Remap Normal Mode
-- 0.0.2 Remap Insert Mode
-- 0.0.3 Remap Visual Mode
-- 0.0.4 Remap Command Mode

-- 0.0.1 Remap Normal Mode
local nmap = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- 0.0.2 Remap Insert Mode
local imap = function(lhs, rhs, desc)
	vim.keymap.set("i", lhs, rhs, { desc = desc })
end

-- 0.0.3 Remap Visual Mode
local vmap = function(lhs, rhs, desc)
	vim.keymap.set("v", lhs, rhs, { desc = desc })
end

-- 0.0.4 Remap Command Mode
local cmap = function(lhs, rhs, desc)
	vim.keymap.set("c", lhs, rhs, { desc = desc })
end



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

---@module 'fileLayout.title'
local function title()
	require("fileLayout.title").addTitle()
end
nmap_leader("00", title, "insert title")

nmap("cc", require("core.colorcolumn").cycle)
nmap("<leader>L", function()
    if vim.opt.spelllang:get()[1] == "en" then
        -- Schakel over naar Nederlands
        vim.opt.spelllang = "nl"
        vim.opt.dictionary = "/usr/share/dict/dutch"
        vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/nl.utf-8.add"
        print("Spelling & Dictionary gewijzigd naar: Nederlands")
    else
        -- Schakel terug naar Engels
        vim.opt.spelllang = "en"
        vim.opt.dictionary = "/usr/share/dict/american-english-insane"
        vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
        print("Spelling & Dictionary gewijzigd naar: Engels")
    end
end, "Toggle taal (EN/NL) voor spelling en dictionary")

cmap("Wq", "wq")
cmap("Q","q")

cmap("<Up>", function()
	if vim.fn.getcmdtype() == ":" then
		vim.schedule(function()
			require("telescope.builtin").command_history({
				results_title = "Command History",
				prompt_title = "",
				selection_caret = " ",
			})
		end)
		return "<C-c>"
	else
		return "<Up>"
	end
end, "Open Telescope command history")
