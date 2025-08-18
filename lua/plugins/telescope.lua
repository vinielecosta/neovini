-- ~/.config/nvim/lua/plugins/telescope.lua
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

                -- MAPEAMENTOS CORRIGIDOS E MELHORADOS
                mappings = {
                    i = {
                        -- Navegação na lista
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,

                        -- Ações de abertura
                        ['<CR>'] = actions.select_default,
                        ['<C-x>'] = actions.select_vertical, -- NOVO ATALHO para split vertical
                        ['<C-s>'] = actions.select_horizontal, -- BÔNUS: atalho para split horizontal

                        -- Outras ações
                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist
                    }
                },

                highlights = {
                    TelescopeNormal = {
                        bg = "NONE"
                    },
                    TelescopeBorder = {
                        bg = "NONE"
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
