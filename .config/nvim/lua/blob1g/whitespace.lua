local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight extra space
-- FF4050
-- F43841
vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#F43841" })

local config = {
	highlight = "TrailingWhitespace",
	ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },
	ignore_terminal = true,
	clean_trailing_whitespace = true,
}

local whitespace = {}
local function should_highlight()
	if vim.bo.buftype == "nofile" then
		return false
	end

	if config.ignore_terminal and vim.bo.buftype == "terminal" then
		return false
	end

	if vim.tbl_contains(config.ignored_filetypes, vim.bo.filetype) then
		return false
	end

	return true
end

whitespace.highlight = function()
	if not vim.fn.hlexists(config.highlight) then
		error(string.format("highlight %s does not exist", config.highlight))
	end

	if should_highlight() then
		local command = string.format([[match %s /\s\+$/]], config.highlight)
		vim.cmd(command)
	else
		vim.cmd("match")
	end
end

whitespace.trim = function()
	local save_cursor = vim.fn.getpos(".")

	vim.cmd([[keeppatterns %substitute/\v\s+$//eg]])
	vim.fn.setpos(".", save_cursor)
end

whitespace.setup = function(options)
	config = vim.tbl_extend("force", config, options or {})

	augroup("whitespace_nvim", { clear = true })
	vim.api.nvim_create_autocmd(
		"FileType",
		{ group = "whitespace_nvim", pattern = "*", callback = whitespace.highlight }
	)
	vim.api.nvim_create_autocmd(
		"TermOpen",
		{ group = "whitespace_nvim", pattern = "*", callback = whitespace.highlight }
	)
	vim.api.nvim_create_autocmd(
		"BufEnter",
		{ group = "whitespace_nvim", pattern = "*", callback = whitespace.highlight }
	)
	vim.api.nvim_create_autocmd(
		"UIEnter",
		{ group = "whitespace_nvim", pattern = "*", callback = whitespace.highlight }
	)

	if config.clean_trailing_whitespace then
		autocmd('FileType', {
			pattern = 'bash,c,cpp,lua,java,go,php,javascript,make,python,rust,perl,sql,markdown',
			callback = function()
				autocmd('BufWritePre', {
					pattern = '<buffer>',
					callback = whitespace.trim,
				})
			end
		})
	end
end

return whitespace
