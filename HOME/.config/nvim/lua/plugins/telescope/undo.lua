local action_layout = require("telescope.actions.layout")
require("telescope").setup({
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		undo = {
			use_delta = true,
			use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
			side_by_side = true,
			vim_diff_opts = {
				ctxlen = vim.o.scrolloff,
			},
			entry_format = "state #$ID, $STAT, $TIME",
			time_format = "",
			saved_only = false,
			layout_strategy = "horizontal",
			layout_config = {
				anchor = "SW",
				width = 0.99,
				height = 0.99,
				preview_width = 0.8,
			},
			mappings = {
				i = {
					["<C-Up>"] = require("telescope.actions").preview_scrolling_up,
					["<C-Down>"] = require("telescope.actions").preview_scrolling_down,
				},
				n = {
					["<C-Up>"] = require("telescope.actions").preview_scrolling_up,
					["<C-Down>"] = require("telescope.actions").preview_scrolling_down,
				},
			},
		},
	},
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("undo")
vim.keymap.set("n", "u", "<cmd>Telescope undo<cr>")
