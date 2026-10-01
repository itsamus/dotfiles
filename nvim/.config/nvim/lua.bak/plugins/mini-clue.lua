require("mini.clue").setup({
	-- Array of extra clues to show
	clues = {
		-- Voeg hier eventueel extra groep-beschrijvingen toe als je geen mini.starter/etc gebruikt
		{ mode = "n", keys = "<Leader>0", desc = "+Headings" },
		{ mode = "n", keys = "<Leader>f", desc = "+Find" },
	},

	-- Array of opt-in triggers which start custom key query process.
	-- **Needs to have something in order to show clues**.
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },

		-- Marks
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = "`" },
		{ mode = "x", keys = "'" },
		{ mode = "x", keys = "`" },

		-- Registers
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- Z key
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
	},

	-- Clue window settings
	window = {

		-- Floating window config
		config = {},

		-- Delay before showing clue window
		delay = 0,

		-- Keys to scroll inside the clue window
		scroll_down = "<C-down>",
		scroll_up = "<C-up>",
	},
})

vim.api.nvim_set_hl(0, "MiniClueBorder", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueDescGroup", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueDescSingle", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueNextKey", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueNextKeyWithPostkeys", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueSeparator", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MiniClueTitle", { fg = "NONE", bg = "NONE" })
