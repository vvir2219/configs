-- terminal
vim.keymap.set('n', '<c-/>', function ()
  local splitbelow = vim.opt.splitbelow

  vim.opt.splitbelow = true
  vim.cmd('split')
  vim.cmd('silent terminal')
  vim.cmd('set nonumber')
  vim.cmd('set norelativenumber')
  vim.cmd('startinsert')
  vim.opt.splitbelow = splitbelow
end)

vim.keymap.set('n', '<c-x>', function ()
  vim.cmd('wa')
  vim.cmd("silent make | execute '!./' . expand('%<')")
end)
