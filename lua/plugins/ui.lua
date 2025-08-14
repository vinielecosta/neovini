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
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            -- you can enable a preset theme if you like
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false -- add a border to hover docs and signature help
            }
        })
    end
}}
