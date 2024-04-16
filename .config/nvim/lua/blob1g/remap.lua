vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>rw', vim.cmd.Oil)

-- useful thingies

vim.keymap.set('n', '<C-c>', '<C-^>')

-- dvorak remappings

vim.keymap.set({ 'n', 'x' }, 'h', 'j')
vim.keymap.set({ 'n', 'x' }, 't', 'k')
vim.keymap.set({ 'n', 'x' }, 'n', 'l')

vim.keymap.set({ 'n', 'x' }, ';', ':')
vim.keymap.set({ 'n', 'x' }, ':', ';')

vim.keymap.set({ 'n', 'x' }, 'm', 'n')
vim.keymap.set({ 'n', 'x' }, 'M', 'N')

-- some benefits

vim.keymap.set({ 'n', 'x' }, '-', '$')
vim.keymap.set({ 'n', 'x' }, '_', '^')
vim.keymap.set({ 'n', 'x' }, 'H', '8<Down>')
vim.keymap.set({ 'n', 'x' }, 'T', '8<Up>')

vim.keymap.set('n', 'N', '<C-w><C-w>')
vim.keymap.set('n', '<C-h>', '<C-w>j')
vim.keymap.set('n', '<C-t>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-\'>', '<C-w>h')

-- from the primagen

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-q>", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
  "n",
  "<leader>ee",
  "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- diff with unsaved version
vim.keymap.set('n', '<leader>df', function()
  local filetype = vim.bo.filetype
  local linenr = vim.fn.line(".")

  vim.cmd.diffthis()
  vim.cmd.new()
  vim.cmd('r #')
  vim.cmd('normal! 1Gdd')
  vim.cmd.diffthis()
  vim.cmd("setlocal bt=nofile bh=wipe nobl noswf ro ft=" .. filetype)
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = vim.api.nvim_get_current_buf(), silent = true })

  vim.api.nvim_create_autocmd('WinClosed', {
    callback = function()
      vim.cmd("normal" .. linenr .. "G")
    end,
    buffer = vim.api.nvim_get_current_buf(),
  })
end)
