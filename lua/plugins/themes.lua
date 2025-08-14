-- ~/.config/nvim/lua/plugins/themes.lua
return { -- TEMA DRACULA (NOVO E ATIVO)
{
    'Mofiqul/dracula.nvim',
    priority = 1000, -- Garante que o tema seja carregado antes de outros plugins de UI
    config = function()
        require('dracula').setup({
            -- Ativa o fundo transparente
            transparent_bg = true,

            -- Mostra nomes de cores em itálico, como 'local' ou 'self'
            show_end_of_buffer = true, -- Mostra os caracteres '~' no final do buffer

            -- Configurações de integração com outros plugins
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = true,
                treesitter = true,
                dap = true
            }
        })

        -- Define o Dracula como o esquema de cores padrão ao iniciar
        vim.cmd.colorscheme('dracula')
    end
}, -- TEMA CATPUCCIN (ANTIGO E DESATIVADO)
-- Nós comentamos o bloco abaixo para que o lazy.nvim não o carregue mais.
--[[
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- Outras opções: latte, frappe, macchiato
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = true,
          treesitter = true,
          dap = {
            enabled = true,
            enable_ui = true, -- Requer nvim-dap-ui
          },
        },
      })
      -- Define o tema como padrão ao iniciar
      vim.cmd.colorscheme('catppuccin')
    end,
  },
  ]] --
-- Barra de Status (Lualine)
{
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('lualine').setup({
            options = {
                -- O Lualine tem um tema dracula integrado que será usado
                theme = 'dracula'
                -- ... outras opções do lualine
            }
        })
    end
}}
