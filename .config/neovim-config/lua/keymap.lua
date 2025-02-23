local vim = vim
local Base = {
    movement = {
        {
            { "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "go to next wrapline" },
        },
        { { "n", "v" }, "k",         "v:count == 0 ? 'gk' : 'k'",                    { expr = true, silent = true, desc = "go to previous wrapline" }, },
        { { "n", "v" }, "L",         "g_",                                           { desc = "go to line end" } },
        { { "n", "v" }, "H",         "^",                                            { desc = "go to line begin" } },

        -- page scroll
        { { "n", "v" }, "<C-u>",     math.floor(vim.fn.winheight(0) / 2) .. "<C-u>", { desc = "scroll half page forward" }, },
        { { "n", "v" }, "<C-d>",     math.floor(vim.fn.winheight(0) / 2) .. "<C-d>", { desc = "scroll half page backward" }, },

        { "n",          "<C-i>",     "<C-i>",                                        { desc = "fix conflict caused by <Tab> mapping, no need in vscode" }, },
        -- { "n",          "<Tab>", "<C-w>W",                                       { desc = "move to window" } },
        { "n",          "<leader>|", "<C-w>v",                                       { desc = "split window" } },
        { "n",          "<leader>-", "<C-w>s",                                       { desc = "vsplit window" } },
        { "n",          "<C-h>",     require('smart-splits').move_cursor_left,       { desc = "focus leftside window" } },
        { "n",          "<C-j>",     require('smart-splits').move_cursor_down,       { desc = "focus downside window" } },
        { "n",          "<C-k>",     require('smart-splits').move_cursor_up,         { desc = "focus upside window" } },
        { "n",          "<C-l>",     require('smart-splits').move_cursor_right,      { desc = "focus rightside window" } },
    },
    edit = {
        { "n", "<C-a>",       "ggVG",   { desc = "select all" } },
        { "i", "<C-BS>",      "<C-W>",  { desc = "delete word forward" } },
        { "v", "y",           '"*ygvy', { desc = "copy" } },
        { "n", "yw",          "yiw",    { desc = "copy the word where cursor locates" } },
        { "n", "<C-S-v>",     "<C-v>",  { desc = "start visual mode blockwise" } },
        { "v", ">",           ">gv",    { desc = "indent while keeping virtual mode after " } },
        { "v", "<",           "<gv",    { desc = "indent while keeping virtual mode after " } },
        { "n", "<Backspace>", "ciw",    { desc = "delete word and edit in normal mode" } },
        { "v", "<Backspace>", "c",      { desc = "delete and edit in visual mode" } },
        { "x", "i",           "I",      { desc = "column insert" } },
        { "x", "a",           "A",      { desc = "column append" } },
    },
    cmd = {
        { { "n", "v" }, ";",     ":",           { nowait = true, desc = "enter commandline mode" } },
        { "n",          "q",     "<CMD>q!<CR>", { desc = "quit neovim" } },
        { "n",          "Q",     "q",           { desc = "macro record" } },
        { "n",          "g=",    vim.g.format,  { desc = "format document" } },
        { "n",          "<C-s>", "<CMD>w<CR>",  { desc = "save file" } },
        -- { "n",          "<leader>mk", "<CMD>wa<CR><CMD>!python3 ./build.py<CR>",           { desc = "build" } },
        -- { "n",          "<leader>cl", "<CMD>!python3 ./build.py clean<CR>",                { desc = "build" } },
    },
    lsp = {
        { "n", "gn", vim.lsp.buf.rename,        { desc = "rename symbol" } },
        { "n", "gh", vim.lsp.buf.hover,         { desc = "show documentation" } },
        { "n", "ge", vim.diagnostic.open_float, { desc = "show diagnostic" } },
        { "n", "gd", vim.lsp.buf.definition,    { desc = "go to definition" } },
    },
    fold = {
        { "n", "<leader><CR>",  "za", { desc = "toggle fold" } },
        { "n", "<2-LeftMouse>", "za", { desc = "toggle fold" } },
    },
    modeSwitch = {
        { "i", "<ESC>", "<C-O><CMD>stopinsert<CR>", { desc = "exit to normal mode while keeping cursor location" } },
    },
    comment = {
        { "v", "<C-/>", "gc",  { desc = "comment", remap = true, silent = true } },
        { "v", "<C-_>", "gc",  { desc = "comment", remap = true, silent = true } },
        { "n", "<C-/>", "gcc", { desc = "comment", remap = true, silent = true } },
        { "n", "<C-_>", "gcc", { desc = "comment", remap = true, silent = true } },
    },
    misc = {
        { "n", "<ESC>", "<CMD>noh<CR><ESC>", { desc = "clear search highlight" } },
    },
}

local Plugin = {
    fzf = {
        { "n", "<leader>F",  function() vim.cmd("FzfLua") end,                        { desc = "fzf-lua" }, },
        { "n", "<leader>w",  function() require("fzf-lua").live_grep() end,           { desc = "search word" }, },
        { "n", "<leader>cw", function() require("fzf-lua").grep_cWORD() end,          { desc = "search current word" }, },
        { "n", "<leader>f",  function() require("fzf-lua").files() end,               { desc = "search file" }, },
        { "n", "z",          function() require("fzf-lua").buffers() end,             { desc = "search buffer" }, },
        { "n", "ga",         function() require("fzf-lua").lsp_code_actions() end,    { desc = "code action" }, },
        { "n", "gr",         function() require("fzf-lua").lsp_references() end,      { desc = "find reference" }, },
        { "n", "gR",         '<Cmd>lua vim.lsp.buf.references()<CR>',                 { desc = "find reference" }, },
        { "n", "gi",         function() require("fzf-lua").lsp_implementations() end, { desc = "find implementations" }, },
        { "n", "gI",         '<Cmd>lua vim.lsp.buf.implementation()<CR>',             { desc = "find reference" }, },
    },
    -- more keymaps in cmp.lua
    cmp = {},
    -- more keymaps in utils.lua
    surround = {},
    -- more keymaps in neotree.lua
    neotree = { { "n", "t", function() vim.cmd("Neotree reveal toggle") end, { desc = "toggle neotree" }, }, },
    grug_far = {
        { "n", "<leader>h", function() require('grug-far').open(opts) end, { desc = "search and replayce" } },
    },
    -- more keymaps in utils.lua
    dropbar = {},
    todo = {
        -- todo的键绑定貌似有bug，并且TodoLocList、TodoQuickFix貌似查到的结果不全
        -- { "n", "]t", function() require("todo-comments").jump_next() end,                                    { desc = "Next todo comment" } },
        -- { "n", "[t", function() require("todo-comments").jump_prev() end,                                    { desc = "Previous todo comment" } },
        -- { "n", "]t", function() require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } }) end, { desc = "Next error/warning todo comment" } },
    },
    hop = {
        { "n", "<leader>e", function()
            require("hop")
            vim.cmd("HopWordAC")
        end, { desc = "hop word in after content" } },
        { "n", "<leader>b", function()
            require("hop")
            vim.cmd("HopWordBC")
        end, { desc = "hop word in before content" } },
        { "n", "<leader>j", function()
            require("hop")
            vim.cmd("HopLineAC")
        end, { desc = "hop line in after content" } },
        { "n", "<leader>k", function()
            require("hop")
            vim.cmd("HopLineBC")
        end, { desc = "hop line in before content" } },
    },
    fterm = {
        { "n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>",            { desc = "open fterm" } },
        { "t", "<A-i>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", { desc = "open fterm" } },
        { "n", "<A-g>", function()
            require("FTerm"):new({
                ft = "fterm_git",
                cmd = "tig",
                -- cmd = "lazygit",
                -- cmd="gitui",
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                }
            }):toggle()
        end, { desc = "open git in fterm" } },
        { "n", "<leader>g", function()
            require("FTerm"):new({
                ft = "fterm_git",
                -- cmd="tig",
                cmd = "lazygit",
                -- cmd="gitui",
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                }
            }):toggle()
        end, { desc = "open git in fterm" } },
    },
}

vim.g.register_keymap(Base)
vim.g.register_keymap(Plugin)
