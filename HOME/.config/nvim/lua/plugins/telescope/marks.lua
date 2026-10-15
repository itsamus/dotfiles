require("telescope").setup({
	pickers = {
		marks = {
			layout_strategy = "horizontal",
			layout_config = {
				anchor = "SE",       -- SE staat voor South-East (Rechtsonder)
				width = 0.78,         -- Totale breedte (640 voor results/prompt + 640 voor de previ55)
				height = 0.99,        -- Volledige hoogte van boven naar beneden
				preview_width = 0.66,
			},
			mark_type = "global",
			-- Hier kun je specifieke opties voor de marks picker instellen
			show_line = true,   -- Toont de regel waar de mark naar verwijst in de voorbeeldweergave
			results_title = "Bookmarked Files",
			prompt_title = "",
			preview_title = "",

			entry_maker = function(entry)
				local make_entry = require("telescope.make_entry")
				local base_maker = make_entry.gen_from_marks()
				local obj = base_maker(entry)

				if obj and obj.display then
					-- Dit pakt de mark + het regelnummer, en verwijdert het kolomnummer dat erachter staat
					obj.display = obj.display:gsub("^(%S+%s+%d+)%s+%d+","%1")
				end

				return obj
			end,
		},
	},
})
