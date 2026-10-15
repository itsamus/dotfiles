local M = {}

-- Definieer de rand-opties met een visueel voorbeeld voor de prompt
local borders = {
	["Strak (Rechts) ┌┬┐"] = {
		"┌",
		"┬",
		"┐",
		"├",
		"┼",
		"┤",
		"└",
		"┴",
		"┘",
		"│",
		"─",
	},
	["Rond (Modern) ╭┬╮"] = {
		"╭",
		"┬",
		"╮",
		"├",
		"┼",
		"┤",
		"╰",
		"┴",
		"╯",
		"│",
		"─",
	},
	["Simpel (Plus) +++"] = {
		"+",
		"+",
		"+",
		"+",
		"+",
		"+",
		"+",
		"+",
		"+",
		"|",
		"-",
	},
}

local function update_tables_file(border_name, border_chars)
	-- Vind hetpad naar je Neovim config directory
	local config_path = vim.fn.stdpath("config")
	local file_path = config_path .. "/lua/plugins/markdown/tables.lua"

	local file = io.open(file_path, "r")
	if not file then
		vim.notify("Kan bestand niet vinden op: " .. file_path, vim.log.levels.ERROR)
		return
	end
	local content = file:read("*a")
	file:close()

	-- Bouw de nieuwe Lua-tabel string op basis van je keuze
	local formatted_border = "border = {\n"
	for _, char in ipairs(border_chars) do
		formatted_border = formatted_border .. "        '" .. char .. "',\n"
	end
	formatted_border = formatted_border .. "    }"

	-- Vervang de tekst tussen de markers in tables.lua
	local pattern = "%-%-%s*%[BORDER_START%].-()%-%-%s*%[BORDER_END%]"
	local replacement = "-- [BORDER_START]\n    " .. formatted_border .. "\n    -- [BORDER_END]"

	local new_content, count = content:gsub(pattern, replacement)

	if count > 0 then
		local write_file = io.open(file_path, "w")
		if write_file then
			write_file:write(new_content)
			write_file:close()
			vim.notify("Markdown tables border gewijzigd naar: " .. border_name, vim.log.levels.INFO)

			-- Optioneel:herlaad de module zodat je veranderingen direct actief worden
			vim.cmd("silent! edit " .. file_path)
		end
	else
		vim.notify("Geen [BORDER_START] / [BORDER_END] markers gevonden in tables.lua", vim.log.levels.ERROR)
	end
end

function M.select_markdown_border()
	local keys = {}
	for name, _ in pairs(borders) do
		table.insert(keys, name)
	end
	table.sort(keys)

	vim.ui.select(keys, {
		prompt = "Kies een Markdown tabel rand (Wordt direct opgeslagen):",
	}, function(choice)
		if choice then
			update_tables_file(choice, borders[choice])
		end
	end)
end

return M
