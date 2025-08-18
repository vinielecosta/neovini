-- ~/.config/nvim/lua/plugins/ui.lua
return { -- File Explorer (Nvim-Tree)
{
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('nvim-tree').setup({
            sort_by = 'case_sensitive',
            view = {
                width = 30
            },
            renderer = {
                group_empty = true
            },
            filters = {
                dotfiles = false
            },
            -- ADIÇÃO PARA USAR A LIXEIRA
            trash = {
                cmd = "trash" -- Certifique-se de ter um comando de lixeira instalado
            }
        })
        -- Mapeamento para abrir/fechar o Nvim-Tree
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
            desc = 'Abrir/Fechar File Explorer'
        })
    end
}, -- Ícones para a UI
{'nvim-tree/nvim-web-devicons'}, -- Notificações
{
    'rcarriga/nvim-notify',
    config = function()
        require('notify').setup({
            background_colour = '#000000'
        })
    end
}, -- Melhora a UI para mensagens, cmdline, etc.
{
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify'},
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false
            }
        })
    end
}}
