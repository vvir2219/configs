vim.pack.add({ 'https://github.com/sainnhe/everforest' })
vim.pack.add({ 'https://github.com/morhetz/gruvbox' })
vim.pack.add({ 'https://github.com/AlexvZyl/nordic.nvim' })
vim.pack.add({ 'https://github.com/everviolet/nvim' })
vim.pack.add({ 'https://github.com/lifepillar/vim-gruvbox8' }, { version = 'neovim' })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local name = vim.g.colors_name
    if not name or not name:match("^gruvbox") then
      print('name does not match ^gruvbox')
      return
    end

    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal" })
    if not ok or not hl.fg then
      print('normal not found')
      return
    end

    vim.api.nvim_set_hl(0, "@variable", { fg = hl.fg })
    vim.api.nvim_set_hl(0, "@property", { fg = hl.fg })
    vim.api.nvim_set_hl(0, "@field", { fg = hl.fg })
    vim.api.nvim_set_hl(0, "@identifier", { fg = hl.fg })
  end,
})

-- vim.g.everforest_background = "hard"
-- vim.cmd.colorscheme('everforest')
vim.cmd.colorscheme('gruvbox8_hard')
