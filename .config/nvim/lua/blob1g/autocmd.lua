local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local go_group = create_augroup("GoGroup", { clear = true })

-- defining local go error snippet
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local errwr_snippet = s("error_handler", {
  t("if "), i(1, "err"), t({" != nil {", "\treturn fmt.Errorf(\""}), i(2, ""), t({" %w\", err)", "}"})
})

-- go
create_autocmd("filetype", {
  group=go_group,
  pattern="go",
  callback = function ()
    vim.keymap.set("i", "e$", function ()
      ls.snip_expand(errwr_snippet)
    end, { buffer = true })
  end
})
