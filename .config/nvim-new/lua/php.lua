vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { "wp-config.php" })
    if not root then
      return
    end

    vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
    vim.opt_local.path:append(root .. "/**")
  end,
})

