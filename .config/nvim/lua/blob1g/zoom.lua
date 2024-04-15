-- map <silent> zi :tabedit +<C-r>=line(".")<cr> %<cr>zz
-- map <silent> Zi :only<cr>
-- map <silent> zo :call ZoomOut()<cr>

function ZoomIn()
  if vim.fn.winnr("$") > 1 then
    vim.cmd("tabedit +" .. vim.fn.line(".") .. " %")
  end
end

function ZoomOut()
  local linenr = vim.fn.line(".")
  vim.cmd("tabclose")
  vim.cmd("normal" .. linenr .. "G")
end

vim.keymap.set("n", 'zi', ZoomIn, { silent = true })
vim.keymap.set("n", 'zo', ZoomOut, { silent = true })
vim.keymap.set("n", 'Zi', vim.cmd.only, { silent = true })
