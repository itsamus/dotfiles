-- ─────────────────────────────────────────────────────────────────────────╮
-- configuration for lsp, autocompletions, snippets, formatters and linters │
-- ─────────────────────────────────────────────────────────────────────────┴───
-- Table of Contents

-- 1. MASON
-- 2. MASON-LSPCONFIG
-- 2.1 LUA_LS

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. MASON

require("mason").setup({
	ui = {
		border = "double",
		width = 0.8,
		height = 1,
		icons = {
			package_installed = "",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. MASON-LSPCONFIG

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"bashls",
		"html",
		"marksman",
	},
	automatic_enable = false,
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 2.1. LUA_LS

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
})
vim.lsp.enable("lua_ls")

-- ─────────────────────────────────────────────────────────────────────────────
-- MARKSMAN

vim.lsp.enable("marksman")

-- ─────────────────────────────────────────────────────────────────────────────
require("mason-tool-installer").setup({
	ensure_installed = {
		"shfmt",
		"shellcheck",
		"luacheck",
		"stylua",
	},
	-- run_on_start = true,
	-- start_delay = 3000,
})
vim.cmd("MasonToolsUpdate")

require("lint").linters_by_ft = {
	lua = { "luacheck" },
	bash = { "shellcheck" },
	sh = { "shellcheck" },
}

require("conform").setup({
	-- Map of filetype to formatters
	formatters_by_ft = {
		lua = { "stylua" },
		-- Use the "*" filetype to run formatters on all filetypes.
		["*"] = { "codespell" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
	-- Set this to change the default values when calling conform.format()
	-- This will also affect the default values for format_on_save/format_after_save
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- If this is set, Conform will run the formatter on save.
	-- It will pass the table to conform.format().
	-- This can also be a function that returns the table.
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	-- If this is set, Conform will run the formatter asynchronously after save.
	-- It will pass the table to conform.format().
	-- This can also be a function that returns the table.
	format_after_save = {
		lsp_format = "fallback",
	},
	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.ERROR,
	-- Conform will notify you when a formatter errors
	notify_on_error = true,
	-- Conform will notify you when no formatters are available for the buffer
	notify_no_formatters = true,
	-- Custom formatters and overrides for built-in formatters
	formatters = {
		my_formatter = {
			-- This can be a string or a function that returns a string.
			-- When defining a new formatter, this is the only field that is required
			command = "my_cmd",
			-- A list of strings, or a function that returns a list of strings
			-- Return a single string instead of a list to run the command in a shell
			args = { "--stdin-from-filename", "$FILENAME" },
			-- If the formatter supports range formatting, create the range arguments here
			range_args = function(self, ctx)
				return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
			end,
			-- Send file contents to stdin, read new contents from stdout (default true)
			-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
			-- file is assumed to be modified in-place by the format command.
			stdin = true,
			-- A function that calculates the directory to run the command in
			cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
			-- When cwd is not found, don't run the formatter (default false)
			require_cwd = true,
			-- When stdin=false, use this template to generate the temporary file that gets formatted
			tmpfile_format = ".conform.$RANDOM.$FILENAME",
			-- When returns false, the formatter will not be used
			condition = function(self, ctx)
				return vim.fs.basename(ctx.filename) ~= "README.md"
			end,
			-- Exit codes that indicate success (default { 0 })
			exit_codes = { 0, 1 },
			-- Environment variables. This can also be a function that returns a table.
			env = {
				VAR = "value",
			},
			-- Set to false to disable merging the config with the base definition.
			-- Can also be set to the name of the formatter to merge with (e.g. inherit = "black")
			inherit = true,
			-- When inherit = true, add these additional arguments to the beginning of the command.
			-- This can also be a function, like args
			prepend_args = { "--use-tabs" },
			-- When inherit = true, add these additional arguments to the end of the command.
			-- This can also be a function, like args
			append_args = { "--trailing-comma" },
		},
		-- These can also be a function that returns the formatter
		other_formatter = function(bufnr)
			return {
				command = "my_cmd",
			}
		end,
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.lsp.config("bashls", {
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
})
vim.lsp.enable("bashls")
