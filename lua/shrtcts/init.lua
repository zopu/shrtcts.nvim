local M = {} -- M stands for module, a naming convention

function FindRightWindow()
	local current_win = vim.api.nvim_get_current_win()
	local windows = vim.api.nvim_list_wins()

	local found_current = false
	for _, win in ipairs(windows) do
		if found_current then
			return win
		end
		if win == current_win then
			found_current = true
		end
	end

	return nil
end

function FindLeftWindow()
	local current_win = vim.api.nvim_get_current_win()
	local windows = vim.api.nvim_list_wins()

	local prev_win = nil
	for _, win in ipairs(windows) do
		if win == current_win then
			return prev_win
		end
		prev_win = win
	end
	return nil
end

function OpenBufInOtherWindow(win)
	local current_buf = vim.api.nvim_get_current_buf()
	if win == nil then
		return
	end

	vim.api.nvim_win_set_buf(win, current_buf)
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_win_set_cursor(win, cursor_pos)
end

function OpenBufInRhsWindow()
	OpenBufInOtherWindow(FindRightWindow())
end

function OpenBufInLhsWindow()
	OpenBufInOtherWindow(FindLeftWindow())
end

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("ShrtCtOpenBufInRhsWindow", OpenBufInRhsWindow, {})
	vim.api.nvim_create_user_command("ShrtCtOpenBufInLhsWindow", OpenBufInLhsWindow, {})
end

function M.openBufInRhsWindow()
	OpenBufInRhsWindow()
end

function M.openBufInLhsWindow()
	OpenBufInLhsWindow()
end

return M
