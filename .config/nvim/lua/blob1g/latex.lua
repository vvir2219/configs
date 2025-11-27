local autocmd = vim.api.nvim_create_autocmd

-- vimtex
vim.g.tex_compile_success = false
vim.g.term_pdf_viewer_open = false

local customTex = vim.api.nvim_create_augroup("CustomTex", {})

autocmd("User", {
    group = customTex,
    pattern = "VimtexEventCompileSuccess",
    callback = function()
        vim.g.tex_compile_success = true
        vim.fn.system('kitty @ send-text --match title:termpdf "q\\r"')
        TermPdfOpenAtCurrentPage()
    end,
})

autocmd("User", {
    group = customTex,
    pattern = "VimtexEventCompileFailed",
    callback = function()
        vim.g.tex_compile_success = false
    end,
})

function VimtexPDFToggle()
    if vim.g.term_pdf_viewer_open then
        vim.fn.system("kitty @ close-window --match title:termpdf")
        vim.g.term_pdf_viewer_open = false
    elseif vim.g.tex_compile_success then
        vim.fn.system("kitty @ launch --location=vsplit --cwd=current --title=termpdf")
        vim.g.term_pdf_viewer_open = true

        TermPdfOpenAtCurrentPage()
    end
end

function TexCurrentPdfPage(pdf)
    local vimtex = vim.b.vimtex
    if not vimtex or not vimtex.root or not vimtex.name then
        print("VimTeX project not initialized")
        return
    end

    local file = vim.fn.expand("%:p")
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")

    -- Run synctex to get the page number
    local cmd = string.format("synctex view -i %d:%d:%s -o %s", line, col, file, pdf)
    local output = vim.fn.systemlist(cmd)

    for _, l in ipairs(output) do
        if l:match("Page:") then
            local page = l:match("Page:%s*(%d+)")
            return page
        end
    end
end

function TermPdfOpenAtCurrentPage()
    local vimtex = vim.b.vimtex
    if not vimtex or not vimtex.root or not vimtex.name then
        print("VimTeX project not initialized")
        return
    end

    local pdf = vimtex.root .. "/" .. vimtex.name .. ".pdf"
    local page = TexCurrentPdfPage(pdf)

    -- Open the PDF at the found page using termpdf.py
    local command = "termpdf.py -p " .. page .. " " .. pdf .. "\r"
    local kitty = "kitty @ send-text --match title:termpdf "

    vim.fn.system(kitty .. command)
end

function TermPdfGotoCurrentPage()
    vim.fn.system('kitty @ send-text --match title:termpdf "q\\r"')
    TermPdfOpenAtCurrentPage()
end

-- snippets

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function make_label(args)
    local text = args[1][1] or ""
    local cleaned = text:lower():gsub("%s+", "_"):gsub("[^a-z_]", "")
    return "cha:" .. cleaned
end

local cha_snip = s("cha", {
    t("\\chapter{"), i(1, "Titlul capitolului"), t("}%"),
    t({ "", "\\label{" }), f(make_label, { 1 }), t("}"),
})

local bigskip_snip = s("bs", {
    t("\\bigskip")
})

local introchapter_snip = s("intro", {
    t("\\bigskip"), t({ "", "" }),
    t("\\introchapter{cha:"), i(1, "modele_teoretice"), t("}{"),
    t({ "", "    " }), i(2, "Descrierea capitolului, posibil pe mai multe linii..."),
    t({ "", "}" }),
})

local function expand_snip(snip)
    return function()
        ls.snip_expand(snip)
    end
end


-- remaps

autocmd("filetype", {
    group = customTex,
    pattern = "tex",
    callback = function()
        local opts = { buffer = true, noremap = true, silent = true }

        -- Lowercase mappings
        vim.keymap.set("i", "s,", "ş", opts)
        vim.keymap.set("i", "s, ", "s, ", opts)
        vim.keymap.set("i", "t,", "ţ", opts)
        vim.keymap.set("i", "t, ", "t, ", opts)
        vim.keymap.set("i", "a(", "ă", opts)
        vim.keymap.set("i", "a>", "â", opts)
        vim.keymap.set("i", "i>", "î", opts)

        -- Uppercase mappings
        vim.keymap.set("i", "S,", "Ş", opts)
        vim.keymap.set("i", "S, ", "S, ", opts)
        vim.keymap.set("i", "T,", "Ţ", opts)
        vim.keymap.set("i", "T, ", "T, ", opts)
        vim.keymap.set("i", "A(", "Ă", opts)
        vim.keymap.set("i", "A>", "Â", opts)
        vim.keymap.set("i", "I>", "Î", opts)

        vim.keymap.set("n", "<leader>t", ":lua VimtexPDFToggle()<cr>", opts)
        vim.keymap.set("n", "<leader>v", ":lua TermPdfGotoCurrentPage()<cr>", opts)

        -- ls.add_snippets("tex", { cha_snip })
        vim.keymap.set("i", "cha$", expand_snip(cha_snip), opts)
        vim.keymap.set("i", "bs$", expand_snip(bigskip_snip), opts)
        vim.keymap.set("i", "ic$", expand_snip(introchapter_snip), opts)
    end
})
