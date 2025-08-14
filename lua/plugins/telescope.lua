return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                path_display = {'truncate'},
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist
                    }
                }
            }
        })

        local keymap = vim.keymap.set
        keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {
            desc = 'Buscar Arquivos'
        })
        keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {
            desc = 'Buscar por Texto (Grep)'
        })
        keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {
            desc = 'Buscar em Buffers Abertos'
        })
        keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {
            desc = 'Buscar na Ajuda'
        })
    end
}
