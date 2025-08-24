-- ~/.config/nvim/lua/plugins/ui.lua
-- This file groups plugins responsible for the user interface (UI)

return {  

    ----------------------------------------------------------------------
    -- github-nvim-theme: Main theme
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
        vim.cmd.colorscheme('github_dark')
        end,
    },

    ----------------------------------------------------------------------
    -- nvim-web-devicons: Icons for file types
    ----------------------------------------------------------------------
    {'nvim-tree/nvim-web-devicons'}, 

    ----------------------------------------------------------------------
    -- nvim-tree.lua: File Explorer
    ----------------------------------------------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'}, 
        config = function()
            require('nvim-tree').setup({
                -- Sort files in a case-sensitive way
                sort_by = 'case_sensitive',
                -- File explorer window settings
                view = {
                -- MUDANÇA AQUI: Define a largura como uma tabela para ajuste dinâmico
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
                    },
                    group_empty = true, -- Show empty folders
                    full_name = true, -- Show full file names
                    highlight_modified = "all", -- Highlight files based on git status
                },
                -- File filters
                filters = {
                    dotfiles = false -- Show hidden files (e.g., .gitignore)
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
                    cmd = "trash" -- Requires a command-line trash utility
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

    ----------------------------------------------------------------------
    -- zen-mode.nvim: "Zen" mode for total focus
    ----------------------------------------------------------------------
    {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup()
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
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('lualine').setup({
                options = {
                    -- IMPORTANT: Change the theme here to match the active theme.
                    -- Options: 'dracula', 'tokyonight', 'catppuccin', 'gruvbox', 'github'.
                    theme = 'dracula'
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                }
            })
        end
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
    }

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