return {
    {
        -- todo的键绑定貌似有bug，并且TodoLocList、TodoQuickFix貌似查到的结果不全
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
        end
    },
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        lazy = false,
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' can be specified
            });
        end
    },
    {
        'numToStr/FTerm.nvim',
        config = function()
            require 'FTerm'.setup({
                border     = 'single',
                dimensions = {
                    height = 0.7,
                    width = 0.7,
                    -- x = 0.9,
                    -- y = 0.9,
                },
            })
        end
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
    },
    {
        'abecodes/tabout.nvim',
        lazy = false,
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true,            -- shift content if tab out is not possible
                act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>',  -- reverse shift default action,
                enable_backwards = true,      -- well ...
                completion = false,           -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '<', close = '>' }
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        dependencies = { -- These are optional
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp"
        },
        opt = true,              -- Set this to true if the plugin is optional
        event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
        priority = 1000,
    },
    {
        "L3MON4D3/LuaSnip",
        keys = function()
            -- Disable default tab keybinding in LuaSnip
            return {}
        end,
    },
    {
        'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash',
        lazy = false,
    },
    {
        "ibhagwan/fzf-lua",
        config = true,
        lazy = false,
    },
    {
        "windwp/nvim-autopairs",
        config = true,
        event = { "InsertEnter" },
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "User Lazyest",
        config = true,
    },
    {
        "echasnovski/mini.hipatterns",
        version = false,
        event = "User Lazyest",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    {
        -- ufo can prevent blocking nvim with treesitter fold method
        -- which is weird when switching to a buffer with large file
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "User Lazyest",
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ("  %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end
            require("ufo").setup({
                provider_selector = function()
                    return { "treesitter", "indent" }
                end,
                fold_virt_text_handler = handler,
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    visual = "s",
                    normal = "ys",
                    delete = "ds",
                    change = "cs",
                },
                surrounds = {
                    ["("] = false,
                    ["["] = false,
                },
                -- remove leading and trailing whitespace
                aliases = {
                    ["("] = ")",
                    ["["] = "]",
                },
            })
        end,
        event = "User Lazyest",
    },
    {
        "folke/flash.nvim",
        event = "User Lazyest",
        config = function()
            require("flash").setup({
                labels = "abcdefghijklmnopqrstuvwxyz0123456789",
                label = {
                    rainbow = {
                        enabled = true,
                        -- number between 1 and 9
                        shade = 5,
                    },
                    uppercase = false,
                    distance = true,
                },
                modes = {
                    -- options used when flash is activated through
                    -- a regular search with `/` or `?`
                    search = {
                        enabled = true, -- enable flash for search
                    },
                    -- options used when flash is activated through
                    -- `f`, `F`, `t`, `T`, `;` and `,` motions
                    char = {
                        enabled = false,
                    },
                    -- options used for treesitter selections
                    -- `require("flash").treesitter()`
                    treesitter = {
                        enabled = false,
                        labels = "abcdefghijklmnopqrstuvwxyz0123456789",
                        label = { before = true, after = true, style = "inline" },
                        jump = { pos = "range" },
                        highlight = {
                            backdrop = false,
                            matches = false,
                        },
                    },
                },
                -- options for the floating window that shows the prompt,
                -- for regular jumps
                prompt = {
                    enabled = false,
                },
                jump = {
                    pos = "end",
                    autojump = false,
                },
            })
        end,
    },
}
