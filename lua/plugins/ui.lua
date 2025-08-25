-- ~/.config/nvim/lua/plugins/ui.lua
-- This file groups plugins responsible for the user interface (UI)

return {

    ----------------------------------------------------------------------
    -- kanagawa.nvim: Main theme
    ----------------------------------------------------------------------

    { "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            colors = {
                theme = {
                        all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            } 
        })
        vim.cmd("colorscheme kanagawa")
    end
    },

    ----------------------------------------------------------------------
    -- github-nvim-theme: 
    ----------------------------------------------------------------------
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({
                options = {
                    transparent = true
                }
            })
            -- vim.cmd.colorscheme('github_dark')
        end,
    },

    ----------------------------------------------------------------------
    -- nvim-web-devicons: Icons for file types
    ----------------------------------------------------------------------
    { 'nvim-tree/nvim-web-devicons' },

    ----------------------------------------------------------------------
    -- nvim-tree.lua: File Explorer
    ----------------------------------------------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup({
                -- Sort files in a case-sensitive way
                sort_by = 'case_sensitive',
                -- File explorer window settings
                view = {
                    width = {
                        min = 20, -- Largura mínima
                        max = 60, -- Largura máxima
                    },
                },
                -- Rendering settings
                renderer = {
                    icons = {
                        show = {
                            modified = true,
                        },
                        glyphs = {
                            git = {
                                deleted = "",
                            }
                        }
                    },
                    group_empty = true,         -- Show empty folders
                    full_name = true,           -- Show full file names
                    highlight_modified = "all", -- Highlight files based on git status
                },
                -- File filters
                filters = {
                    dotfiles = false  -- Show hidden files (e.g., .gitignore)
                },
                hijack_cursor = true, -- Keep the cursor on the first letter of the filename
                -- Configure delete action to move files to trash
                modified = {
                    enable = true
                },
                update_focused_file = {
                    enable = true
                },
                trash = {
                    cmd = "trash" -- Requires a command-line trash utility, use "D" to send files to the trash bin
                }
            })
        end
    },

    ----------------------------------------------------------------------
    -- neokinds: Icons for autocompletion menu and diagnostics
    ----------------------------------------------------------------------
    {
        'thebigcicca/neokinds',
        config = function()
            require('neokinds').setup({
                icons = {
                    error = "",
                    warn = "",
                    hint = "",
                    info = ""
                },
                completion_kinds = {
                    Text = " ",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = " ",
                    Field = "",
                    Variable = " ",
                    Class = "󰠱 ",
                    Interface = " ",
                    Module = " ",
                    Property = "󰜢 ",
                    Unit = " ",
                    Value = " ",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = " ",
                    File = " ",
                    Reference = " ",
                    Folder = " ",
                    EnumMember = " ",
                    Constant = " ",
                    Struct = "",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = " ",
                    Boolean = " ",
                    Array = " "
                }
            })
        end
    },

    {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup()
        vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end
},

    ----------------------------------------------------------------------
    -- zen-mode.nvim: "Zen" mode for total focus
    ----------------------------------------------------------------------
    {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup({
                window = {
                    width = 200,
                    height = 1
                },
                plugins = {
                    twilight = { enabled = true },
                    gitsigns = { enabled = true },
                },
            })
        end
    },

    ----------------------------------------------------------------------
    -- twilight.nvim: Single code block focus mode
    ----------------------------------------------------------------------
    {
        "folke/twilight.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }

    },

    ----------------------------------------------------------------------
    -- lualine.nvim: Customizable status bar
    ----------------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    -- IMPORTANT: Change the theme here to match the active theme.
                    -- Options: 'dracula', 'tokyonight', 'catppuccin', 'gruvbox', 'github'.
                    theme = 'dracula'
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                }
            })
        end
    },

    {
        "j-hui/fidget.nvim",
            opts = {
                -- options
            },
            window = {
                  normal_hl = "Comment",      -- Base highlight group in the notification window
                  winblend = 0,             -- Background color opacity in the notification window
                  border = "none",            -- Border around the notification window
                  zindex = 45,                -- Stacking priority of the notification window
                  max_width = 0,              -- Maximum width of the notification window
                  max_height = 0,             -- Maximum height of the notification window
                  x_padding = 1,              -- Padding from right edge of window boundary
                  y_padding = 0,              -- Padding from bottom edge of window boundary
                  align = "bottom",           -- How to align the notification window
                  relative = "editor",        -- What the notification window position is relative to
                  tabstop = 8,                -- Width of each tab character in the notification window
            },
    },

    ----------------------------------------------------------------------
    -- bufferin.nvim: Minimalist buffer manager (this block configures bufferin locally, comment it out if desired)
    ----------------------------------------------------------------------
    {
        dir = "C:/Users/lucaseb/AppData/Local/nvim-data/lazy/bufferin.nvim",

        cmd = { "Bufferin" },
        config = function()
            require('bufferin').setup({
                display = {
                    show_numbers = false
                },
                show_window_layout = true,
                icons = {
                    provider = "builtin"
                }
            })
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    },

    -- To use bufferin.nvim, uncomment the section below
    ----------------------------------------------------------------------
    -- bufferin.nvim: Minimalist buffer manager
    ----------------------------------------------------------------------
    -- {
    --     'wasabeef/bufferin.nvim',
    --     cmd = { "Bufferin" },
    --     config = function()
    --         require('bufferin').setup({
    --         display = {
    --             show_numbers = false
    --         },
    --         show_window_layout = true,
    --         icons = {
    --             provider = "builtin"
    --         }
    --         })
    --     end,
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons'
    --     }
    -- }
}
