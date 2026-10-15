require("neotest").setup({
    adapters = {
        require("neotest-bash")({
            executable = vim.env.HOME .. "/EX-programs/lib/bashunit",
        }),
    },
})
