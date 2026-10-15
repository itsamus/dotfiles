local M = {}

local function expand_to_word_boundaries(line, col)
    if #line == 0 then return 0, 0 end
    col = math.min(col + 1, #line)

    local char = line:sub(col, col)
    if char:match("%s") then
        local left, right = col, col
        while left > 1 and line:sub(left - 1, left - 1):match("%s") do left = left - 1 end
        while right < #line and line:sub(right + 1, right + 1):match("%s") do right = right + 1 end
        if not line:sub(left, left):match("%s") then
            col = left
        elseif not line:sub(right, right):match("%s") then
            col = right
        else
            return col - 1, col - 1
        end
    end

    local start_idx = col
    while start_idx > 1 and not line:sub(start_idx - 1, start_idx - 1):match("%s") do
        start_idx = start_idx - 1
    end

    local end_idx = col
    while end_idx < #line and not line:sub(end_idx + 1, end_idx + 1):match("%s") do
        end_idx = end_idx + 1
    end

    return start_idx - 1, end_idx - 1
end

function M.format_selection()
    local s_pos = vim.fn.getpos("'<")
    local e_pos = vim.fn.getpos("'>")

    local start_row, start_col = s_pos[2], s_pos[3] - 1
    local end_row, end_col = e_pos[2], e_pos[3] - 1

    if start_row == 0 or end_row == 0 then
        print("Geen actieve visuele selectie gevonden.")
        return
    end

    if start_row > end_row or (start_row == end_row and start_col > end_col) then
        start_row, end_row = end_row, start_row
        start_col, end_col = end_col, start_col
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
    if #lines == 0 then return end

    local mode = vim.fn.visualmode()
    local parsed_rows = {}
    local max_col_widths = {}
    local block_target_scol = nil

    if mode == "\22" then
        block_target_scol = math.min(start_col, end_col)
    end

    -- Stap 1: Analyseer alle regels en pas woordgrenzen toe
    for i, line in ipairs(lines) do
        local s_col, e_col

        if mode == "\22" then -- Ctrl-v (Blockwise visual)
            s_col = block_target_scol
            e_col = math.max(start_col, end_col)

            -- Vul korte regels aan met spaties tot de startkolom
            if #line < s_col then
                line = line .. string.rep(" ", s_col - #line)
            end

            if #line > 0 and s_col < #line then
                s_col = expand_to_word_boundaries(line, s_col)
                _, e_col = expand_to_word_boundaries(line, e_col)
            end
        else
            s_col = (i == 1) and start_col or 0
            e_col = (i == #lines) and end_col or #line
            s_col = math.min(s_col, #line)
            e_col = math.min(e_col, #line)

            if i == 1 and #line > 0 then
                s_col = expand_to_word_boundaries(line, s_col)
            end
            if i == #lines and #line > 0 then
                _, e_col = expand_to_word_boundaries(line, e_col)
            end
        end

        local selected_text = string.sub(line, s_col + 1, e_col + 1)
        local words = {}
        for word in string.gmatch(selected_text, "%S+") do
            table.insert(words, word)
        end

        for c_idx, word in ipairs(words) do
            max_col_widths[c_idx] = math.max(max_col_widths[c_idx] or 0, vim.fn.strdisplaywidth(word))
        end

        table.insert(parsed_rows, {
            line_idx = i,
            line = line,
            s_col = s_col,
            e_col = e_col,
            words = words
        })
    end

    -- Stap 2: Controleer en corrigeer de uitlijning van de start-pipes bij een blokselectie
    if mode == "\22" and #parsed_rows > 0 then
        local max_s_col = 0
        for _, row in ipairs(parsed_rows) do
            if #row.words > 0 then
                max_s_col = math.max(max_s_col, row.s_col)
            end
        end

        -- Trek de startkolommen gelijk zodat de eerste '|' perfect onder elkaar komt te staan
        for _, row in ipairs(parsed_rows) do
            if #row.words > 0 and row.s_col < max_s_col then
                local diff = max_s_col - row.s_col
                row.line = string.sub(row.line, 1, row.s_col) .. string.rep(" ", diff) .. string.sub(row.line, row.s_col + 1)
                row.e_col = row.e_col + diff
                row.s_col = max_s_col
            end
        end
    end

    -- Stap 3: Bouw de regels opnieuw op met uitgelijnde kolommen
    for _, row in ipairs(parsed_rows) do
        if #row.words > 0 then
            local formatted_words = {}
            for c_idx, word in ipairs(row.words) do
                local padding = max_col_widths[c_idx] - vim.fn.strdisplaywidth(word)
                table.insert(formatted_words, word .. string.rep(" ", padding))
            end

            local formatted = "| " .. table.concat(formatted_words, " | ") .. " |"
            local new_line = string.sub(row.line, 1, row.s_col) .. formatted .. string.sub(row.line, row.e_col + 2)
            lines[row.line_idx] = new_line
        end
    end

    vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

return M

-- local M = {}
--
-- local function expand_to_word_boundaries(line, col)
--     if #line == 0 then return 0, 0 end
--     col = math.min(col + 1, #line)
--
--     local char = line:sub(col, col)
--     if char:match("%s") then
--         local left, right = col, col
--         while left > 1 and line:sub(left - 1, left - 1):match("%s") do left = left - 1 end
--         while right < #line and line:sub(right + 1, right + 1):match("%s") do right = right + 1 end
--         if not line:sub(left, left):match("%s") then
--             col = left
--         elseif not line:sub(right, right):match("%s") then
--             col = right
--         else
--             return col - 1, col - 1
--         end
--     end
--
--     local start_idx = col
--     while start_idx > 1 and not line:sub(start_idx - 1, start_idx - 1):match("%s") do
--         start_idx = start_idx - 1
--     end
--
--     local end_idx = col
--     while end_idx < #line and not line:sub(end_idx + 1, end_idx + 1):match("%s") do
--         end_idx = end_idx + 1
--     end
--
--     return start_idx - 1, end_idx - 1
-- end
--
-- function M.format_selection()
--     local s_pos = vim.fn.getpos("'<")
--     local e_pos = vim.fn.getpos("'>")
--
--     local start_row, start_col = s_pos[2], s_pos[3] - 1
--     local end_row, end_col = e_pos[2], e_pos[3] - 1
--
--     if start_row == 0 or end_row == 0 then
--         print("Geen actieve visuele selectie gevonden.")
--         return
--     end
--
--     if start_row > end_row or (start_row == end_row and start_col > end_col) then
--         start_row, end_row = end_row, start_row
--         start_col, end_col = end_col, start_col
--     end
--
--     local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
--     if #lines == 0 then return end
--
--     local mode = vim.fn.visualmode()
--
--     for i, line in ipairs(lines) do
--         local s_col, e_col
--
--         if mode == "\22" then -- Ctrl-v (Blockwise visual)
--             s_col = math.min(start_col, end_col)
--             e_col = math.max(start_col, end_col)
--
--             s_col = math.min(s_col, #line)
--             e_col = math.min(e_col, #line)
--
--             if #line > 0 and s_col < #line then
--                 s_col = expand_to_word_boundaries(line, s_col)
--                 _, e_col = expand_to_word_boundaries(line, e_col)
--             end
--         else
--             s_col = (i == 1) and start_col or 0
--             e_col = (i == #lines) and end_col or #line
--
--             s_col = math.min(s_col, #line)
--             e_col = math.min(e_col, #line)
--
--             if i == 1 and #line > 0 then
--                 s_col = expand_to_word_boundaries(line, s_col)
--             end
--             if i == #lines and #line > 0 then
--                 _, e_col = expand_to_word_boundaries(line, e_col)
--             end
--         end
--
--         local selected_text = string.sub(line, s_col + 1, e_col + 1)
--
--         local words = {}
--         for word in string.gmatch(selected_text, "%S+") do
--             table.insert(words, word)
--         end
--
--         if #words > 0 then
--             local formatted = "| " .. table.concat(words, " | ") .. " | "
--             local new_line = string.sub(line, 1, s_col) .. formatted .. string.sub(line, e_col + 2)
--             lines[i] = new_line
--         end
--     end
--
--     vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
-- end
--
-- return M
