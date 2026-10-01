local M = {}

require('nvim-treesitter')
local isssx t_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end

-- Enable tree-sitter after opening a file for a target language
local filetypes = {}
for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
    end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')

return M
