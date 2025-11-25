local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local go_group = create_augroup("GoGroup", { clear = true })

-- defining local go error snippet
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local errwr_snippet = s("error_handler", {
  -- t("if "), i(1, "err"), t({" != nil {", "\treturn fmt.Errorf(\""}), i(2, ""), t({" %w\", err)", "}"})
  t({ "if err != nil {", "\tlogger.Error.Println(err)", "\treturn " }),
  i(1, ""),
  t({ "", "}" })
})

-- go
create_autocmd("filetype", {
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
create_autocmd("filetype", {
  pattern = "sql",
  callback = function()
    local opts = { silent = true, buffer = true }
    vim.keymap.set("n", "<leader>r", "<Plug>(sqls-execute-query)", opts)
    vim.keymap.set("x", "<leader>r", "<Plug>(sqls-execute-query)", opts)
    vim.keymap.set("n", "<leader>rv", "<Plug>(sqls-execute-query-vertical)", opts)
    vim.keymap.set("x", "<leader>rv", "<Plug>(sqls-execute-query-vertical)", opts)
  end
})

-- templ
create_autocmd("filetype", {
  pattern = "templ",
  callback = function()
    vim.opt_local.commentstring = "/*%s*/"
  end
})

-- clean trailing whitespace
--
-- Source - https://stackoverflow.com/a
-- Posted by lcheylus, modified by community. See post 'Timeline' for change history
-- Retrieved 2025-11-25, License - CC BY-SA 4.0

local trim_whitespace = create_augroup('trim_whitespaces', { clear = true })
create_autocmd('FileType', {
  group = trim_whitespace,
  desc = 'Trim trailing white spaces',
  pattern = 'bash,c,cpp,lua,java,go,php,javascript,make,python,rust,perl,sql,markdown',
  callback = function ()
    create_autocmd('BufWritePre', {
      pattern = '<buffer>',
      callback = function ()
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespaces
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)
      end
    })
  end
})
