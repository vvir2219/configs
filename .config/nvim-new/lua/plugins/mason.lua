vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({
    ensure_installed = { "phpactor" },
})
