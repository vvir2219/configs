local root = vim.fs.root(0, { "wp-config.php" })

if root then
  vim.opt_local.includeexpr = [[substitute(v:fname, '^/', '', '')]]
  vim.opt_local.path:append(root .. "/**")
end

