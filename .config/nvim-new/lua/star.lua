vim.keymap.set("n", "*", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.setreg("/", "\\<" .. word .. "\\>")
  vim.opt.hlsearch = true
end, { silent = true })

vim.keymap.set("n", "#", function()
  local word = vim.fn.expand("<cword>")
  vim.fn.setreg("/", "\\<" .. word .. "\\>")
  vim.opt.hlsearch = true
end, { silent = true })

vim.keymap.set("v", "*", function()
  vim.cmd('normal! "zy')
  vim.fn.setreg("/", "\\V" .. vim.fn.escape(vim.fn.getreg("z"), "\\"))
  vim.opt.hlsearch = true
end, { silent = true })

