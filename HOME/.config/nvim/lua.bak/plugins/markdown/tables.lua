require("render-markdown").setup({
	pipe_table = {
		enabled = true,
		render_modes = false,
		preset = "none",
		cell = "padded",
		cell_offset = function()
			return 0
		end,
		padding = 1,
		min_width = 0,
		-- [BORDER_START]
		border = {
			"╭",
			"┬",
			"╮",
			"├",
			"┼",
			"┤",
			"╰",
			"┴",
			"╯",
			"│",
			"─",
		},
		-- [BORDER_END]
		border_enabled = true,
		border_virtual = false,
		alignment_indicator = "•",
		head = "RenderMarkdownTableHead",
		row = "RenderMarkdownTableRow",
		style = "full",
	},
})
