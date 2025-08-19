-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        wrap_results = true,

        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_vertical,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        
        -- CORREÇÃO DEFINITIVA PARA TRANSPARÊNCIA
        highlights = {
          -- Liga o fundo do Telescope ao fundo normal do editor
          TelescopeNormal = {
            link = "Normal"
          },
          -- Liga a borda do Telescope ao fundo normal do editor
          TelescopeBorder = {
            link = "Normal"
          },
        },
      },
      pickers = {
        lsp_references = {
          show_line = false,
        },
      },
    })

    local keymap = vim.keymap.set
    keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Buscar Arquivos' })
    keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Buscar por Texto (Grep)' })
    keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buscar em Buffers Abertos' })
    keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Buscar na Ajuda' })
  end,
}
