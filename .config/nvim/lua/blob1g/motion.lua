_G.GoStart = function()
  vim.cmd('normal! `[')
end

_G.GoEnd = function()
  vim.cmd('normal! `]')
end

vim.keymap.set('n', 'gs', function()
  vim.go.opfunc = 'v:lua.GoStart'
  return 'g@'
end, { expr = true })

vim.keymap.set('n', 'ge', function()
  vim.go.opfunc = 'v:lua.GoEnd'
  return 'g@'
end, { expr = true })

