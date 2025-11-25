-- terminal
vim.keymap.set('n', '<c-/>', function ()
  vim.opt.splitbelow = true
  vim.cmd('split')
  vim.cmd('silent terminal')
  vim.cmd('set nonumber')
  vim.cmd('set norelativenumber')
  vim.cmd('startinsert')
end)

vim.keymap.set('n', '<c-x>', function ()
  vim.cmd('wa')
  vim.cmd("silent make | execute '!./' . expand('%<')")
end)
