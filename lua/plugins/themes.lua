-- ~/.config/nvim/lua/plugins/themes.lua
-- Este ficheiro centraliza a configuração de todos os temas visuais e da barra de estado (Lualine).
-- Permite alternar facilmente entre diferentes aparências para o NeoVini.

return {
  ----------------------------------------------------------------------
  -- TEMA 1: Dracula (Ativo por Padrão)
  ----------------------------------------------------------------------
  {
    'Mofiqul/dracula.nvim',
    priority = 1000, -- Garante que o tema seja carregado antes de outros plugins de UI.
    config = function()
      require('dracula').setup({
        transparent_bg = true, -- Ativa o fundo transparente.
        show_end_of_buffer = true,
        -- Ativa a integração de estilos com outros plugins.
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = true,
          treesitter = true,
          dap = true,
        },
        -- Força a transparência em componentes específicos que podem ser sobrescritos.
        custom_highlights = function(colors)
          return {
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { bg = "NONE" },
          }
        end,
      })
      -- Para ativar este tema, mantenha esta linha descomentada.
      -- vim.cmd.colorscheme('dracula')
    end,
  },

  ----------------------------------------------------------------------
  -- TEMA 2: Tokyo Night
  ----------------------------------------------------------------------
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = "night", -- Outros estilos: "storm", "moon".
        transparent = true,
        on_highlights = function(hl, c)
          -- Garante a transparência em componentes do Telescope.
          hl.TelescopeNormal = { bg = "none" }
          hl.TelescopeBorder = { bg = "none" }
        end,
      })
      -- Para ativar este tema, descomente a linha abaixo e comente as outras.
      -- vim.cmd.colorscheme('tokyonight')
    end,
  },

  ----------------------------------------------------------------------
  -- TEMA 3: Catppuccin
  ----------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Outros sabores: "latte", "frappe", "macchiato".
        transparent_background = true,
        integrations = {
          telescope = true,
        },
      })
      -- Para ativar este tema, descomente a linha abaixo e comente as outras.
      -- vim.cmd.colorscheme "catppuccin"
    end,
  },

  ----------------------------------------------------------------------
  -- TEMA 4: Gruvbox
  ----------------------------------------------------------------------
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = "hard",
        overrides = {
          -- Garante a transparência no Telescope.
          TelescopeNormal = { bg = "none" },
        },
      })
      -- Para ativar este tema, descomente a linha abaixo e comente as outras.
      -- vim.cmd.colorscheme('gruvbox')
    end,
  },

  ----------------------------------------------------------------------
  -- TEMA 5: GitHub
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
          nvimtree = true,
        },
      })
      -- Para ativar este tema, descomente uma das linhas abaixo.
      vim.cmd.colorscheme('github_dark')
      -- vim.cmd.colorscheme('github_light')
      -- vim.cmd.colorscheme('github_dimmed')
    end,
  },

  ----------------------------------------------------------------------
  -- Barra de Estado (Lualine)
  ----------------------------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          -- IMPORTANTE: Mude o tema aqui para combinar com o tema ativo.
          -- Opções: 'dracula', 'tokyonight', 'catppuccin', 'gruvbox', 'github'.
          theme = 'dracula',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },
}
