-- ~/.config/nvim/lua/plugins/themes.lua
return { -- TEMA DRACULA
--------------------------------------------------------------------
-- NOVA FEATURE: Barra de Ferramentas (Toolbar)
--------------------------------------------------------------------
{
    'ojroques/nvim-bufbar',
    -- Certifique-se de que a barra de ferramentas carregue com a UI
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('bufbar').setup({
            -- Mostra a barra de ferramentas na parte de cima
            position = "top",
            -- Define os elementos que aparecerão na barra
            elements = { -- Mostra os buffers abertos (ficheiros)
            {
                kind = "buffers",
                -- Como cada buffer será exibido
                item_separator = " | ",
                -- Botões personalizados à esquerda
                left_separator = " ",
                custom_area_left = {{
                    -- Botão para o explorador de ficheiros
                    text = "󰙅 Ficheiros",
                    on_press = function()
                        vim.cmd("NvimTreeToggle")
                    end
                }, {
                    text = "  "
                }, -- Espaçador
                {
                    -- Botão para procurar ficheiros
                    text = "󰍉 Procurar",
                    on_press = function()
                        vim.cmd("Telescope find_files")
                    end
                }},
                -- Botões personalizados à direita
                right_separator = " ",
                custom_area_right = {{
                    -- Botão para rodar testes
                    text = "󰙨 Testes",
                    on_press = function()
                        -- Requer a função que criamos em keymaps.lua
                        -- Para evitar erros, definimos uma função global temporária
                        -- A forma mais robusta seria mover a função para um módulo próprio
                        if _G.run_dotnet_tests then
                            _G.run_dotnet_tests()
                        else
                            vim.cmd("luafile " .. vim.fn.stdpath('config') .. "/lua/core/keymaps.lua")
                            if _G.run_dotnet_tests then
                                _G.run_dotnet_tests()
                            end
                        end
                    end
                }}
            }}
        })
    end
}, {
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
}, --------------------------------------------------------------------
-- TEMA 5: GitHub (NOVO)
--------------------------------------------------------------------
{
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                transparent = true
            },
            integrations = {
                telescope = true,
                nvimtree = true
            }
        })
        -- Para ativar este tema, descomente uma das linhas abaixo
        -- vim.cmd.colorscheme('github_dark')
        -- vim.cmd.colorscheme('github_light')
        -- vim.cmd.colorscheme('github_dimmed')
        vim.cmd.colorscheme('github_dark')
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
