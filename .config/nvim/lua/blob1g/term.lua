-- terminal
vim.keymap.set('n', '<c-/>', function ()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end)

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ot', function() 
  local vim_dir = vim.fn.expand('%:p:h') -- Get the directory of the current file
  -- Open terminal in the specified directory without changing the current working directory
  vim.cmd('split')
  vim.cmd('terminal zsh -c "cd ' .. vim_dir .. ' && exec zsh"')
  vim.cmd('startinsert')
end)

