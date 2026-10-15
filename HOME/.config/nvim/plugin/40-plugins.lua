local now = Config.now
local now_if_args = Config.now_if_args
local later = Config.later

local add = vim.pack.add

-- ─────────────────────╮
-- Configuration Part I │
-- ─────────────────────┴───────────────────────────────────────────────────────

-- Table Of Contents

-- 1. NOW
-- 1.1 Colorizer
-- 1.2 Webdevicons

-- 2.NOW-IF-ARG
-- 2.1 Treesitter

-- 3 LATER
-- 3.2 MINI's
-- 3.2.1 Clues
-- 3.2.2 Align
-- 3.3. Telescope
-- 3.4. Render Markdown
-- 3.5. Undotree

-- 4. LSP

-- ─────────────────────────────────────────────────────────────────────────────
-- NOW
-- 1. Colorizer

now(function()
	add({
		{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
	})
	require("plugins.highlight-colors")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Webdevicons

now(function()
	add({
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	})
	require("plugins.webdivicons")
end)

-- ─────────────────────────────────────────────────────────────────────────────

now_if_args(function()
	-- Define hook to update tree-sitter parsers after plugin is updated
	local ts_update = function()
		vim.cmd("TSUpdate")
	end
	Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

	add({
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	})

	-- Define languages which will have parsers installed and auto enabled
	-- After changing this, restart Neovim once to install necessary parsers. Wait
	-- for the installation to finish before opening a file for added language(s).
	local languages = {
		"awk",
		"bash",
		"bibtex",
		"c",
		"c3",
		"c_sharp",
		"cmake",
		"comment",
		"cooklang",
		"desktop",
		"devicetree",
		"css",
		"diff",
		"editorconfig",
		"embedded_template",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitignore",
		-- "gitcommit",
		"gpg",
		"haskell",
		"haskell_persistent",
		"html",
		-- "latex",
		"html_tags",
		"http",
		-- "hyperlang",
		"idl",
		"ini",
		"java",
		"javadoc",
		"javascript",
		"jq",
		"jsdoc",
		"json",
		"json5",
		"jsonnet",
		"just",
		"kconfig",
		"lua",
		"luadoc",
		"luap",
		"make",
		"markdown",
		"markdown_inline",
		"passwd",
		"php",
		"php_only",
		"phpdoc",
		"printf",
		"properties",
		"pug",
		"python",
		"ql",
		"qmldir",
		"qmljs",
		"readline",
		"regex",
		"requirements",
		"rust",
		"scss",
		"ssh_config",
		"superhtml",
		"svelte",
		"systemtap",
		"todotxt",
		"toml",
		"todotxt",
		-- "typescipt",
		"vim",
		"vimdoc",
		"xcompose",
		"xml",
		"xresources",
		"yaml",
		"xresources",
		"zig",
		"kitty",
		-- These are already pre-installed with Neovim. Used as an example.
		-- Add here more languages with which you want to use tree-sitter
		-- To see available languages:
		-- - Execute `:=require('nvim-treesitter').get_available()`
		-- - Visit 'SUPPORTED_LANGUAGES.md' file at
		--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
	}
	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end
	local to_install = vim.tbl_filter(isnt_installed, languages)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end

	-- Enable tree-sitter after opening a file for a target language
	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local ts_start = function(ev)
		vim.treesitter.start(ev.buf)
	end
	Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.MINI's

-- 2.1 Clues
later(function()
	add({
		{ src = "https://github.com/nvim-mini/mini.clue" },
	})
	require("plugins.mini.clue")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.2 Align
later(function()
	add({
		{ src = "https://github.com/nvim-mini/mini.align" },
	})
	require("plugins.mini.align")
end)

later(function()
	add({
		{ src = "https://github.com/tpope/vim-surround" },
	})
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Telescope

later(function()
	add({
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-fzy-native.nvim" },
		-- { src = "https://github.com/debugloop/telescope-undo.nvim" },
	})
	require("plugins.telescope")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Render Markdown

later(function()
	add({
		{ src = "https://github.com/meanderingprogrammer/render-markdown.nvim" },
	})
	require("plugins.markdown")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. LSP

later(function()
	add({
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
		{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ src = "https://github.com/mfussenegger/nvim-lint" },
		{ src = "https://github.com/stevearc/conform.nvim" },
	})
	require("LSP.full-setup")
end)

later(function()
	require("plugins.vimwiki")
	add({
		{ src = "https://github.com/vimwiki/vimwiki" },
		{ src = "https://github.com/mattn/calendar-vim" },
	})
	-- require("plugins.calendar")
end)
