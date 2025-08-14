-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy', -- Carrega o plugin de forma preguiçosa para otimizar o startup
    config = function()
        require('gitsigns').setup({
            -- Sinais visuais que aparecerão na calha (gutter)
            signs = {
                add = {
                    text = '▎'
                },
                change = {
                    text = '▎'
                },
                delete = {
                    text = ''
                },
                topdelete = {
                    text = ''
                },
                changedelete = {
                    text = '▎'
                },
                untracked = {
                    text = '▎'
                }
            },
            -- Função que é executada quando o gitsigns se anexa a um buffer
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local keymap = vim.keymap.set

                -- Cria os atalhos apenas para este buffer
                local opts = {
                    buffer = bufnr
                }

                -- Navegação entre Hunks (blocos de alteração)
                keymap('n', ']h', function()
                    gs.next_hunk()
                end, opts)
                keymap('n', '[h', function()
                    gs.prev_hunk()
                end, opts)

                -- Ações de Hunk
                -- <leader>hs => Hunk Stage (adiciona o bloco ao stage do git)
                keymap('n', '<leader>hs', gs.stage_hunk, opts)
                -- <leader>hr => Hunk Reset (reverte as alterações do bloco)
                keymap('n', '<leader>hr', gs.reset_hunk, opts)
                -- Adiciona o hunk ao stage no modo visual
                keymap('v', '<leader>hs', function()
                    gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")})
                end, opts)
                -- Reverte o hunk no modo visual
                keymap('v', '<leader>hr', function()
                    gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")})
                end, opts)

                -- Ações de Buffer
                -- <leader>hS => Stage Buffer (adiciona todas as alterações do arquivo ao stage)
                keymap('n', '<leader>hS', gs.stage_buffer, opts)
                -- <leader>hR => Reset Buffer (reverte todas as alterações do arquivo)
                keymap('n', '<leader>hR', gs.reset_buffer, opts)

                -- Outras Ações Úteis
                -- <leader>hp => Preview Hunk (mostra as alterações do bloco em uma janela flutuante)
                keymap('n', '<leader>hp', gs.preview_hunk, opts)
                -- <leader>hb => Blame Line (mostra quem foi o autor da alteração da linha atual)
                keymap('n', '<leader>hb', function()
                    gs.blame_line({
                        full = true
                    })
                end, opts)
            end
        })
    end
}
