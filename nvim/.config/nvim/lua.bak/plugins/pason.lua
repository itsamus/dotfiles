require("mason").setup()

require("mason-lspconfig").setup({
    automatic_enable = false,
})
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "bashls",
        "basedpyright",
        "marksman",
        "ruff",
        "stylua",
    },
})

vim.cmd("MasonToolsInstall")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
            },
            disableTaggedHints = true,
        },
    },
})
vim.lsp.enable("basedpyright")

vim.lsp.config("marksman", {
    settings = {
        marksman = {
            core = {
                markdown_file_extensions = { "md", "markdown" },
                markdown = {
                    glfm_heading_ids = {
                        enable = true,
                    },
                },
                text_sync = "full",
                title_from_heading = true,
                incremental_references = false,
                paranoid = false,
            },
            code_action = {
                toc = {
                    enable = true,
                    include = { 1, 2, 3, 4, 5, 6 },
                },
                create_missing_file = {
                    enable = true,
                },
            },
            completion = {
                candidates = 50,
                wiki = {
                    style = "title-slug",
                },
            },
        },
    },
})

-- Vergeet niet om de server ook in te schakelen voor markdown bestanden:
vim.lsp.enable("marksman")
