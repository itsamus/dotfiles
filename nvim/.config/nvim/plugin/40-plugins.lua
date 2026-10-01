local now = Config.now
local now_if_args = Config.now_if_args
local later = Config.later

local add = vim.pack.add

-- ─────────────────────╮
-- Configuration Part I │
-- ─────────────────────┴───────────────────────────────────────────────────────

-- Table Of Contents

-- 0. Mini's
-- 0.0 Mini-Clue

-- ─────────────────────────────────────────────────────────────────────────────

now(function()
	add({
		{ src = 'https://github.com/norcalli/nvim-colorizer.lua' }
	})
	require("plugins.colorizer")
end)

later(function()
	add({
		{ src = 'https://github.com/nvim-mini/mini.clue' }
	})
	require("plugins.mini.clue")
end)

later(function()
	add({
		{ src = 'https://github.com/nvim-lua/plenary.nvim' },
		{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
		{ src = 'https://github.com/nvim-telescope/telescope-fzy-native.nvim' },
	})
	require("plugins.telescope")
end)

later(function()
add({
	{ src = 'https://github.com/meanderingprogrammer/render-markdown.nvim' }
})
require("plugins.markdown")
end)
