local M = {}

--- Achterhaalt en transformeert de commentstring van de huidige buffer.
--- @return string De aangepaste commentstring
function M.addComment()
    local cs = vim.bo.commentstring

    -- Fallback als de commentstring leeg is
    if not cs or cs == "" then
        cs = "// %s"
    end

    -- Splits de commentstring op basis van de placeholder '%s'
    local left, right = cs:match("(.*)%%s(.*)")

    if not left then
        return cs
    end

    left = vim.trim(left)
    right = right and vim.trim(right) or ""

    -- Controleer of er zowel een prefix als een suffix bestaat (bijv. /* %s */)
    if right ~= "" then
        return string.format("%s %%s %s", left, right)
    else
        -- Als de prefix uit 1 teken/symbool bestaat, verdubbel deze dan
        if vim.fn.strchars(left) == 1 then
            left = left .. left
        end
        return string.format("%s %%s", left)
    end
end

return M

-- local M = {}
--
-- --- Achterhaalt en transformeert de commentstring van de huidige buffer.
-- --- @return string De aangepaste commentstring
--
-- function M.addComment()
--     local cs = vim.bo.commentstring
--
--     -- Fallback als de commentstring leeg is
--     if not cs or cs == "" then
--         cs = "// %s"
--     end
--
--     -- Splits de commentstring op basis van de placeholder '%s'
--     local left, right = cs:match("(.*)%%s(.*)")
--
--     if not left then
--         return cs
--     end
--
--     left = vim.trim(left)
--     right = right and vim.trim(right) or ""
--
--     -- Controleer of er zowel een prefix als een suffix bestaat (bijv. /* %s */)
--     if right ~= "" then
--         -- Zorg ervoor dat de suffix correct aan het einde staat
--         return string.format("%s %%s %s", left, right)
--     else
--         -- Bestaat uit een enkel symbool/prefix (bijv. # %s of -- %s)
--         -- Als de prefix uit 1 teken/symbool bestaat, verdubbel deze dan
--         if vim.fn.strchars(left) == 1 then
--             left = left .. left
--         end
--         return string.format("%s %%s", left)
--     end
-- end
--
-- return M
