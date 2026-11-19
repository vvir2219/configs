vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })
require('oil').setup({
    default_file_explorer = true,
    watch_for_changes = true,

    view_options = {
        show_hidden = true
    },

    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
})
