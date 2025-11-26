vim.keymap.set("n", "<c-g>", function ()
    local splittype = vim.opt.splitbelow
    vim.opt.splitbelow = false
    vim.cmd.Git()
    vim.opt.splitbelow = splittype
end)
