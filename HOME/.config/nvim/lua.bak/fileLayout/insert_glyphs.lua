local M = {}

function M.get_glyphs_content()
    local glyphs_path = vim.fn.stdpath("config") .. "/glyphs/*"
    local files = vim.fn.glob(glyphs_path, false, true)

    local combined_content = {}

    for _, file in ipairs(files) do
        if vim.fn.filereadable(file) == 1 then
            local lines = vim.fn.readfile(file)
            for _, line in ipairs(lines) do
                table.insert(combined_content, line)
            end
        end
    end

    return combined_content
end

return M
