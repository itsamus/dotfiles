local M = {}

function M.get(win)
  win = win or 0
  local cc = vim.wo[win].colorcolumn

  if cc == "" then
    return 1
  end

  local val = tonumber(cc:match("^%d+"))

  if val == 100 then
    return 2
  elseif val == 120 then
    return 3
  else
    return 1
  end
end

function M.setup(callback)
  local group = vim.api.nvim_create_augroup("ColorColumnDetector", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "OptionSet" }, {
    group = group,
    callback = function(args)
      if args.event == "OptionSet" and vim.v.option_name ~= "colorcolumn" then
        return
      end
      if callback then
        callback(M.get(0))
      end
    end,
  })
end

return M
