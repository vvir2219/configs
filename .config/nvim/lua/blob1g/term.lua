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

vim.keymap.set('t', '<c-esc>', '<c-\\>')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-/>', '<c-\\><c-n><c-w>l')
vim.keymap.set('t', '<C-\'>', '<c-\\><c-n><c-w>h')

