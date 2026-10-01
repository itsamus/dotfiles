require("mason").setup()
require("mason-lspconfig").setup({
    ---@type boolean | string[] | { exclude: string[] }
    automatic_enable = false,
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "htmlhint",
        "html",
        "lua_ls",
        "stylua",
        "selene",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
    debounce_hours = 5,
    integrations = {
        "mason-lspconfig",
        true,
        "mason-null-ls",
        true,
        "mason-nvim-dap",
        true,
    },
})

local luasnip = require("luasnip")
luasnip.setup({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    -- Zorg dat je snippets kunt blijven gebruiken als je door tabbladen springt
    delete_check_events = "TextChanged",
})

require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

require("blink.cmp").setup({
    snippets = {
        preset = "luasnip",
    },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("html", {
    capabilities = capabilities,
    filetypes = { "html", "templ" },
    root_dir = vim.fs.root(0, { "package.json", ".git", "index.html" }) or vim.fn.getcwd(),
    single_file_support = true,
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" },
    },
    settings = {
        html = {
            format = {
                wrapLineLength = 120,
                indentInnerHtml = true,
            },
            validate = {
                scripts = true,
                styles = true,
            },
        },
    },
})

vim.lsp.enable("html")

vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    capabilities = capabilities,
    settings = {
        bashIde = {
            -- Aantal bestanden dat op de achtergrond geanalyseerd mag worden (standaard 500, 0 = uit)
            backgroundAnalysisMaxFiles = 500,

            -- Foutmeldingen tonen voor source-errors (standaard false)
            enableSourceErrorDiagnostics = false,

            -- Glob patroon voor het vinden van shell-bestanden
            globPattern = "**/*@(.sh|.inc|.bash|.command)",

            -- Endpoint voor explainshell integratie voor hover-documentatie (bijv. lokale instance of leeg om uit te zetten)
            explainshellEndpoint = "",

            -- Of alle symbolen in de workspace gebruikt mogen worden voor autocompletion (standaard false)
            includeAllWorkspaceSymbols = false,

            -- Of ShellCheck externe source-bestanden mag volgen (standaard true)
            shellcheckExternalSources = true,

            -- Extra argumenten meegeven aan shellcheck
            shellcheckArguments = "",

            -- Pad naar shellcheck executable (of leeg maken om shellcheck uit te zetten)
            shellcheckPath = "shellcheck",

            -- Instellingen voor shfmt (formatter)
            shfmt = {
                path = "shfmt",
                ignoreEditorconfig = false,
                languageDialect = "auto", -- opties: 'auto', 'bash', 'posix', 'mksh', 'bats'
                binaryNextLine = false,
                caseIndent = false,
                funcNextLine = false,
                keepPadding = false,
                simplifyCode = false,
                spaceRedirects = false,
            },
        },
    },
})
vim.lsp.enable("bashls")

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
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
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
                    vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = vim.api.nvim_get_runtime_file('', true),
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

require("conform").setup({

    -- Map of filetype to formatters
    formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettier" },
        json = { "prettier" },
        toml = { "taplo" },
        yaml = { "prettier" },
        python = { "ruff_fix", "ruff_format" },
        -- Conform will run multiple formatters sequentially
        -- go = { "goimports", "gofmt" },

        -- You can also customize some of the format options for the filetype
        -- rust = { "rustfmt", lsp_format = "fallback" },

        -- You can use a function here to determine the formatters dynamically
        -- python = function(bufnr)
        --     if require("conform").get_formatter_info("ruff", bufnr).available then
        --         return { "ruff" }
        --     else
        --         return { "isort", "black" }
        --     end
        -- end,

        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
    },

    -- -- Set this to change the default values when calling conform.format()
    -- -- This will also affect the default values for format_on_save/format_after_save
    -- default_format_opts = {
    -- 	lsp_format = "fallback",
    -- },

    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = "fallback",
        timeout_ms = 500,
    },

    -- -- If this is set, Conform will run the formatter asynchronously after save.
    -- -- It will pass the table to conform.format().
    -- -- This can also be a function that returns the table.
    -- format_after_save = {
    -- 	lsp_format = "fallback",
    -- },

    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,

    -- Conform will notify you when a formatter errors
    notify_on_error = true,

    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,

    -- Custom formatters and overrides for built-in formatters
    formatters = {
        injected = {
            options = {
                ignore_errors = false,
                lang_to_ft = {
                    bash = "sh",
                },

                lang_to_ext = {
                    bash = "sh",
                    c_sharp = "cs",
                    elixir = "exs",
                    javascript = "js",
                    julia = "jl",
                    latex = "tex",
                    markdown = "md",
                    python = "py",
                    ruby = "rb",
                    rust = "rs",
                    teal = "tl",
                    typescript = "ts",
                },

                lang_to_formatters = {},
            },
        },

        stylua = {
            prepend_args = {
                "--syntax",
                "All",
                "--column-width",
                "120",
                "--line-endings",
                "Unix",
                "--indent-type",
                "Spaces",
                "--indent-width",
                "4",
                "--quote-style",
                "AutoPreferDouble",
                "--call-parentheses",
                "Always",
                "--collapse-simple-statement",
                "Never",
                "--space-after-function-names",
                "Never",
                "--preserve-block-newline-gaps",
                "Never",
            },
        },

        ruff_fix = {
            args = {
                "check",
                "--fix",
                "--line-length=88",
                "--config",
                "indent-width=4",
                "--stdin-filename",
                "$FILENAME",
                "-",
            },
        },
        ruff_format = {
            args = {
                "format",
                "--line-length=88",
                "--config",
                "indent-width=4",
                "--stdin-filename",
                "$FILENAME",
                "-",
            },
        },

        prettier = {
            prepend_args = {
                "--experimental-ternaries",
                "false",
                "--print-width",
                "100",
                "--tab-width",
                "4",
                -- "--semi",
                -- "true",
                "--single-quote",
                "false",
                "--quote-props",
                "as-needed",
                "--jsx-single-quote",
                "false",
                "--trailing-comma",
                "all",
                -- "--no-bracket-spacing",
                -- "true",
                "--object-wrap",
                "preserve",
                "--bracket-same-line",
                "false",
                "--arrow-parens",
                "always",
                "--range-start",
                "0",
                "--range-end",
                "Infinity",
                "--stdin-filepath",
                "None",
                "--require-pragma",
                "false",
                "--insert-pragma",
                "false",
                "--check-ignore-pragma",
                "false",
                "--prose-wrap",
                "preserve",
                "--html-whitespace-sensitivity",
                "css",
                "--vue-indent-script-and-style",
                "false",
                "--end-of-line",
                "lf",
                "--embedded-language-formatting",
                "auto",
                "--single-attribute-per-line",
                "false",
            },

            options = {
                -- Use a specific prettier parser for a filetype
                -- Otherwise, prettier will try to infer the parser from the file name
                ft_parsers = {
                    javascript = "babel",
                    javascriptreact = "babel",
                    typescript = "typescript",
                    typescriptreact = "typescript",
                    vue = "vue",
                    css = "css",
                    scss = "scss",
                    less = "less",
                    html = "html",
                    json = "json",
                    jsonc = "json",
                    yaml = "yaml",
                    markdown = "markdown",
                    ["markdown.mdx"] = "mdx",
                    graphql = "graphql",
                    handlebars = "glimmer",
                },
                -- Use a specific prettier parser for a file extension
                ext_parsers = {
                    qmd = "markdown",
                },
            },
        },

        -- 	my_formatter = {
        -- 		-- This can be a string or a function that returns a string.
        -- 		-- When defining a new formatter, this is the only field that is required
        -- 		command = "my_cmd",
        --
        -- 		-- A list of strings, or a function that returns a list of strings
        -- 		-- Return a single string instead of a list to run the command in a shell
        -- 		args = { "--stdin-from-filename", "$FILENAME" },
        --
        -- 		-- If the formatter supports range formatting, create the range arguments here
        -- 		range_args = function(self, ctx)
        -- 			return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
        -- 		end,
        --
        -- 		-- Send file contents to stdin, read new contents from stdout (default true)
        -- 		-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
        -- 		-- file is assumed to be modified in-place by the format command.
        -- 		stdin = true,
        --
        -- 		-- A function that calculates the directory to run the command in
        -- 		cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
        --
        -- 		-- When cwd is not found, don't run the formatter (default false)
        -- 		require_cwd = true,
        --
        -- 		-- When stdin=false, use this template to generate the temporary file that gets formatted
        -- 		tmpfile_format = ".conform.$RANDOM.$FILENAME",
        --
        -- 		-- When returns false, the formatter will not be used
        -- 		condition = function(self, ctx)
        -- 			return vim.fs.basename(ctx.filename) ~= "README.md"
        -- 		end,
        --
        -- 		-- Exit codes that indicate success (default { 0 })
        -- 		exit_codes = { 0, 1 },
        --
        -- 		-- Environment variables. This can also be a function that returns a table.
        -- 		env = {
        -- 			VAR = "value",
        -- 		},
        --
        -- 		-- Set to false to disable merging the config with the base definition.
        -- 		-- Can also be set to the name of the formatter to merge with (e.g. inherit = "black")
        -- 		inherit = true,
        --
        -- 		-- When inherit = true, add these additional arguments to the beginning of the command.
        -- 		-- This can also be a function, like args
        -- 		prepend_args = { "--use-tabs" },
        --
        -- 		-- When inherit = true, add these additional arguments to the end of the command.
        -- 		-- This can also be a function, like args
        -- 		append_args = { "--trailing-comma" },
        -- 	},
        --
        -- 	-- These can also be a function that returns the formatter
        -- 	other_formatter = function(bufnr)
        -- 		return {
        -- 			command = "my_cmd",
        -- 		}
        -- 	end,
    },
})

require("lint").linters_by_ft = {
    -- lua = { "luacheck" },
    bash = { "shellcheck" },
    sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
