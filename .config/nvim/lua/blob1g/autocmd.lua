local autogroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local go_group = autogroup("GoGroup", { clear = true })

-- defining local go error snippet
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
--
-- local errwr_snippet = s("error_handler", {
--   -- t("if "), i(1, "err"), t({" != nil {", "\treturn fmt.Errorf(\""}), i(2, ""), t({" %w\", err)", "}"})
--   t({ "if err != nil {", "\tlogger.Error.Println(err)", "\treturn " }),
--   i(1, ""),
--   t({ "", "}" })
-- })

local errwr_snippet = s("error_handler", {
  -- t("if "), i(1, "err"), t({" != nil {", "\treturn fmt.Errorf(\""}), i(2, ""), t({" %w\", err)", "}"})
  t({ "if err != nil {", "\treturn err", "}" }),
  i(1, ""),
})

-- go
autocmd("filetype", {
  group = go_group,
  pattern = "go",
  callback = function()
    vim.keymap.set("i", "e$", function()
      ls.snip_expand(errwr_snippet)
    end, { buffer = true })

    -- Custom fold text
    -- function CustomFoldText()
    --   local line = vim.fn.getline(vim.v.foldstart)
    --   if line:match("if err != nil") then
    --     return "error handling"
    --   else
    --     return vim.fn.getline(vim.v.foldstart)
    --   end
    -- end

    -- vim.opt.foldtext = "v:lua.CustomFoldText()"

    -- Highlight fold text
    vim.cmd [[highlight FoldedErrorHandling guifg=red ctermfg=red]]
    vim.cmd [[ syntax match FoldedErrorHandling /.*if err != nil/ ]]

    -- use this to fold errors
    -- :g/\s*if err /normal jva{zf
  end
})

-- sql
autocmd("filetype", {
  pattern = "sql",
  callback = function()
    local opts = { silent = true, buffer = true }
    vim.keymap.set({ "n", "x" }, "<leader>r", "<Plug>(sqls-execute-query)", opts)
    vim.keymap.set({ "n", "x" }, "<leader>rv", "<Plug>(sqls-execute-query-vertical)", opts)
  end
})

-- templ
autocmd("filetype", {
  pattern = "templ",
  callback = function()
    vim.opt_local.commentstring = "/*%s*/"
  end
})

-- fugitive
autocmd('FileType', {
  pattern = "fugitive",
  callback = function()
    vim.keymap.set('n', '<C-g>', ':q<cr>', { buffer = true })
  end
})

-- vim help
autocmd('FileType', {
  pattern = "help",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<c-]>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", "/[|'].\\{-}[|']/<CR>", { silent = true })
  end,
})
