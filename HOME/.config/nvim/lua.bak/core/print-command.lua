local M = {}

function M.run_print_command()
	vim.ui.input({ prompt = "Print Command : " }, function(cmd_input)
		if not cmd_input or cmd_input == "" then
			return
		end
		vim.ui.input({ prompt = "Save to file (path) : " }, function(file_input)
			if not file_input or file_input == "" then
				return
			end

			local filepath = vim.fn.expand(file_input)
			local success, output = pcall(vim.api.nvim_exec2, cmd_input, { output = true })

			if not success then
				vim.notify("Fout bij uitvoeren: " .. tostring(output), vim.log.levels.ERROR)
				return
			end

			local text = output.output or ""
			local file, err = io.open(filepath, "w")
			if not file then
				vim.notify("Kon bestand niet openen: " .. tostring(err), vim.log.levels.ERROR)
				return
			end

			file:write(text)
			file:close()

			vim.notify("Output van '" .. cmd_input .. "' opgeslagen in " .. filepath, vim.log.levels.INFO)
		end)
	end)
end

return M
