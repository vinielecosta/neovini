-- ~/.config/nvim/lua/plugins/themes.lua
return { -- TEMA DRACULA
{
    'Mofiqul/dracula.nvim',
    priority = 1000,
    config = function()
        require('dracula').setup({
            transparent_bg = true,
            show_end_of_buffer = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = true,
                treesitter = true,
                dap = true
            },
            custom_highlights = function(colors)
                return {
                    TelescopeNormal = {
                        bg = "NONE"
                    },
                    TelescopeBorder = {
                        bg = "NONE"
                    }
                }
            end
        })
        vim.cmd.colorscheme('dracula')
    end
}, --------------------------------------------------------------------
-- TEMA 2: Tokyo Night
--------------------------------------------------------------------
{
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('tokyonight').setup({
            style = "night", -- pode ser "storm", "night", ou "moon"
            transparent = true,
            on_highlights = function(hl, c)
                hl.TelescopeNormal = {
                    bg = "none"
                }
                hl.TelescopeBorder = {
                    bg = "none"
                }
            end
        })
        -- Para ativar este tema, descomente a linha abaixo e comente as outras
        -- vim.cmd.colorscheme('tokyonight')
    end
}, --------------------------------------------------------------------
-- TEMA 3: Catppuccin
--------------------------------------------------------------------
{
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            integrations = {
                telescope = true
            }
        })
        -- Para ativar este tema, descomente a linha abaixo e comente as outras
        -- vim.cmd.colorscheme "catppuccin"
    end
}, --------------------------------------------------------------------
-- TEMA 4: Gruvbox
--------------------------------------------------------------------
{
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            transparent_mode = "hard",
            overrides = {
                TelescopeNormal = {
                    bg = "none"
                }
            }
        })
        -- Para ativar este tema, descomente a linha abaixo e comente as outras
        -- vim.cmd.colorscheme('gruvbox')
    end
}, -- Barra de Status (Lualine)
{
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('lualine').setup({
            options = {
                -- MUDANÇA AQUI
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
}}
