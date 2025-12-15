vim.g.mapleader = ' '
vim.keymap.set('n', '<C-e>', vim.cmd.Oil)
-- vim.keymap.set('n', '<c-e>', function()
--   vim.cmd.vs()
--   vim.cmd.Oil()
--   vim.api.nvim_win_set_width(0, 35)
--   vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = vim.api.nvim_get_current_buf(), silent = true })
-- end)

-- useful thingies

vim.keymap.set('n', '<C-c>', '<C-^>')
vim.keymap.set('n', '<leader>d', ':q<cr>')
vim.keymap.set('n', 'X', ':q!<cr>')
vim.keymap.set('n', 'zB', 'zfiB')

-- dvorak remappings

vim.keymap.set({ 'n', 'x', 'o' }, 'h', 'j')
vim.keymap.set({ 'n', 'x', 'o' }, 't', 'k')

vim.keymap.set({ 'n', 'x', 'o' }, ';', ':')
vim.keymap.set({ 'n', 'x', 'o' }, ':', ';')
vim.keymap.set({ 'n', 'x', 'o' }, '&', '%')

vim.keymap.set({ 'n', 'x', 'o' }, '<d-f>', ';')
vim.keymap.set({ 'n', 'x', 'o' }, '<d-b>', ',')

vim.keymap.set({ 'n', 'x', 'o' }, 'j', 't')
vim.keymap.set({ 'n', 'x', 'o' }, 'k', '10')

vim.keymap.set('n', '<leader>m', ':Man<CR>')

-- some benefits

vim.keymap.set({ 'n', 'x', 'o' }, '-', '$')
vim.keymap.set({ 'n', 'x', 'o' }, '_', '^')

vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-\'>', '<C-w>h')

vim.keymap.set('n', '<d-e>', '<c-e>')
vim.keymap.set('n', '<d-y>', '<c-y>')

vim.keymap.set({ "o", "n" }, "'>", "`>")
vim.keymap.set({ "o", "n" }, "'<", "`<")

-- duplicate lines above or below
vim.keymap.set('n', '<leader>[y', 'yyp')
vim.keymap.set('n', '<leader>]y', 'yyP')

-- delete lines above or below
vim.keymap.set('n', '<leader>[d', '<up>dd')
vim.keymap.set('n', '<leader>]d', '<down>dd<up>')

-- from the primagen

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("x", "<leader>f", function()
  local start_pos = vim.api.nvim_buf_get_mark(0, "<")
  local end_pos   = vim.api.nvim_buf_get_mark(0, ">")

  vim.lsp.buf.format({
    range = {
      start = { start_pos[1] - 1, start_pos[2] },
      ["end"] = { end_pos[1] - 1, end_pos[2] },
    },
  })
end, { desc = "Format selection" })

vim.keymap.set("n", "]c", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[c", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-q>", function()
  local qf_winid = -1

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_winid = win["winid"]
    end
  end

  if qf_winid ~= -1 then
    -- if qf_winid == vim.api.nvim_get_current_win() then
    --   vim.cmd.cclose()
    -- else
    --   vim.cmd.wincmd('j')
    -- end
    vim.cmd.cclose()
  else
    vim.cmd.copen()
    vim.cmd.wincmd('J')
  end
end)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>sr", [[:%s/\v/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>ss", [[:%s///gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>sc", [[:%s///gIc<Left><Left><Left><Left>]])
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>s", [[:s/\%V\v/gI<Left><Left><Left>]])
vim.keymap.set("x", "/", [[:s/\%V\v/&/gI<Left><Left><Left><Left><Left>]])

vim.keymap.set("x", "<c-p>", "I<c-r>0<esc>")
vim.keymap.set("x", "<d-p>", "A<c-r>0<esc>")
-- vim.keymap.set("n", "<C-x>r", ":call setreg('a', '@q@a')<CR>@a")

-- restore changes
vim.keymap.set('n', '<leader>cr', ':e!<cr>')

-- diff with unsaved version
vim.keymap.set('n', '<leader>cv', function()
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

-- set current directory to the open file directory

vim.keymap.set('n', '<leader>cd', function()
  local dir = vim.fn.expand('%:p:h')
  vim.cmd('lcd ' .. dir)
end)

-- buffers
vim.keymap.set('n', '<leader>bd', ':bufdo')

-- edit file in current directory
vim.keymap.set('n', '<c-;>e', ':e %:p:h/')
vim.keymap.set('n', '<c-;>v', ':vs %:p:h/')
vim.keymap.set('n', '<c-;>s', ':sp %:p:h/')

-- insert mode commands, emacs like
vim.keymap.set('i', '<c-p>', '<c-o><up>')
vim.keymap.set('i', '<c-n>', '<c-o><down>')
vim.keymap.set('i', '<c-b>', '<c-o><left>')
vim.keymap.set('i', '<c-f>', '<c-o><right>')
vim.keymap.set('i', '<c-s>', '<c-o>/')
vim.keymap.set('i', '<d-s>', '<c-o>n')
vim.keymap.set('i', '<d-S>', '<c-o>N')
vim.keymap.set('i', '<c-&>', '<c-o>%')

vim.keymap.set('i', '<c-a>', '<c-o>I')
vim.keymap.set('i', '<c-e>', '<c-o>A')
vim.keymap.set('i', '<c-k>', '<c-o>D')
vim.keymap.set('i', '<c-d>', '<c-o>x')
vim.keymap.set('i', '<c-/>', '<c-o>u')
vim.keymap.set('i', '<d-/>', '<c-o><c-r>')
vim.keymap.set('i', '<c-y>', '<c-o>"0P')

vim.keymap.set('i', '<d-b>', '<c-o>b')
vim.keymap.set('i', '<d-f>', '<c-o>w')
vim.keymap.set('i', '<d-a>', '<c-o>(')
vim.keymap.set('i', '<d-e>', '<c-o>)')
vim.keymap.set('i', '<d-o>', '<c-o>o')
vim.keymap.set('i', '<d-O>', '<c-o>O')
vim.keymap.set('i', '<d-d>', '<c-o>dw')
