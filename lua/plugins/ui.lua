-- ~/.config/nvim/lua/plugins/ui.lua
-- Este ficheiro agrupa os plugins responsáveis pela interface do utilizador (UI).

return {  

  ----------------------------------------------------------------------
  -- github-nvim-theme: Tema principal
  ----------------------------------------------------------------------
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
        require("github-theme").setup({
            options = {
            transparent = true,
            },
            integrations = {
            telescope = true,
            nvimtree = true
            },
        })
        vim.cmd.colorscheme('github_dark')
        end,
    },

    ----------------------------------------------------------------------
    -- nvim-web-devicons: Ícones para tipos de ficheiro
    ----------------------------------------------------------------------
    {'nvim-tree/nvim-web-devicons'}, 

    ----------------------------------------------------------------------
    -- nvim-tree: Explorador de Ficheiros
    ----------------------------------------------------------------------
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'}, 
        config = function()
            require('nvim-tree').setup({
                -- Ordena os ficheiros de forma sensível a maiúsculas/minúsculas.
                sort_by = 'case_sensitive',
                -- Configurações da janela do explorador.
                view = {
                    width = 30 -- Largura da janela em colunas.
                },
                -- Configurações de renderização.
                renderer = {
                    group_empty = true -- Mostra pastas vazias.
                },
                -- Filtros para ocultar ficheiros.
                filters = {
                    dotfiles = false -- Mostra ficheiros ocultos (ex: .gitignore).
                },
                -- Configura a ação de apagar para mover ficheiros para a lixeira.
                trash = {
                    cmd = "trash" -- Requer um utilitário de lixeira de linha de comando.
                }
            })
        end
    }, 

    ----------------------------------------------------------------------
    -- neokinds: Ícones para o meu de autocompletar e diagnósticos
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
    -- zen-mode: Modo "Zen" para foco total
    ----------------------------------------------------------------------
    {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup()
        end
    }, 

    ----------------------------------------------------------------------
    -- twilight.nvim: Modo de foco em bloco de código único
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
    -- nvim-lualine: Barra de status personalizável
    ----------------------------------------------------------------------
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('lualine').setup({
                options = {
                    -- IMPORTANTE: Mude o tema aqui para combinar com o tema ativo.
                    -- Opções: 'dracula', 'tokyonight', 'catppuccin', 'gruvbox', 'github'.
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
    -- bufferin.nvim: Gerenciador de buffers minimalista (esse bloco configura o bufferin localmente, comente-o caso desejar)
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

    -- Para usar o bufferin.nvim, descomente a seção abaixo.

    ----------------------------------------------------------------------
    -- bufferin.nvim: Gerenciador de buffers minimalista
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