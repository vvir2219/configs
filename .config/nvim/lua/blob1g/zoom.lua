-- map <silent> zi :tabedit +<C-r>=line(".")<cr> %<cr>zz
-- map <silent> Zi :only<cr>
-- map <silent> zo :call ZoomOut()<cr>

function ZoomIn()
  if vim.fn.winnr("$") > 1 then
    local is_terminal = vim.bo.buftype == 'terminal'
    local is_quickfix = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]['quickfix'] == 1

    if is_quickfix then
      vim.api.nvim_win_set_height(0, 500)
    elseif is_terminal then
      vim.api.nvim_win_set_height(0, 500)
      vim.cmd.startinsert()
    else
      vim.cmd("tabedit +" .. vim.fn.line(".") .. " %")
    end
  end
end

function ZoomOut()
  local is_terminal = vim.bo.buftype == 'terminal'
  local is_quickfix = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]['quickfix'] == 1

  if is_quickfix then
    vim.api.nvim_win_set_height(0, 10)
  elseif is_terminal then
    vim.api.nvim_win_set_height(0, 15)
    vim.cmd.startinsert()
  else
    local linenr = vim.fn.line(".")
    if pcall(vim.cmd.close) then
      vim.cmd("normal" .. linenr .. "G")
    end
  end
end

vim.keymap.set("n", 'zi', ZoomIn, { silent = true })
vim.keymap.set("n", 'zo', ZoomOut, { silent = true })
vim.keymap.set("n", 'Zi', vim.cmd.only, { silent = true })
