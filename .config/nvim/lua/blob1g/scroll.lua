local function normal(cmd)
  vim.cmd.normal({ cmd, bang = true })
end

local function ScrollDown()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  if row == 1 then
    normal('Mzz')
  else
    normal('Lzz')
  end
end

local function ScrollUp()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local last = vim.api.nvim_buf_line_count(0)

  if row == last then
    normal('Mzz')
  else
    normal('Hzz')
  end
end

local function ScrollOther(scroll)
  return function()
    local other_nr = vim.fn.winnr('#')
    local other = vim.fn.win_getid(other_nr)
    vim.api.nvim_win_call(other, scroll)
  end
end

vim.keymap.set('n', '<c-d>', ScrollDown)
vim.keymap.set('n', '<c-u>', ScrollUp)

vim.keymap.set('n', '<d-d>', ScrollOther(ScrollDown))
vim.keymap.set('n', '<d-u>', ScrollOther(ScrollUp))

-- vim.keymap.set('n', '<c-d>', '15j')
-- vim.keymap.set('n', '<c-u>', '15k')
