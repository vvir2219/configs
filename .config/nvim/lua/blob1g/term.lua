-- terminal
vim.keymap.set('n', '<c-/>', function()
  if vim.g.terminal_buffer and (not vim.api.nvim_buf_is_valid(vim.g.terminal_buffer)) then
    vim.g.terminal_buffer = nil
  end

  if not vim.g.terminal_buffer then
    vim.g.terminal_buffer = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_call(vim.g.terminal_buffer, function()
      vim.cmd('silent terminal')
      vim.cmd.startinsert()
    end)

    vim.g.terminal_window = vim.api.nvim_open_win(
      vim.g.terminal_buffer, true, {
        split = 'below',
        height = 15
      })
  else
    if vim.g.terminal_window and (not vim.api.nvim_win_is_valid(vim.g.terminal_window)) then
      vim.g.terminal_window = nil
    end

    if vim.g.terminal_window then
      vim.api.nvim_set_current_win(vim.g.terminal_window)
    else
      vim.g.terminal_window = vim.api.nvim_open_win(
        vim.g.terminal_buffer, true, {
          split = 'below',
          height = 15
        })
      vim.api.nvim_buf_call(vim.g.terminal_buffer, function()
        vim.cmd.startinsert()
      end)
    end
  end
end)

vim.keymap.set('n', '<c-x>', function()
  vim.cmd('wa')
  vim.cmd("silent make | execute '!./' . expand('%<')")
end)

vim.keymap.set('t', '<c-esc>', '<c-\\>')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<C-\'>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-q>', '<c-\\><c-n><c-w>l')
vim.keymap.set('t', '<c-/>', '<c-\\><c-n>:q<cr>')

-- terminal
vim.api.nvim_create_autocmd('WinEnter', {
  pattern = 'term://*',
  callback = function ()
    vim.cmd.startinsert()

    if not vim.g.terminal_buffer then
      vim.cmd('set nonumber')
      vim.cmd('set norelativenumber')
    end
  end
})
