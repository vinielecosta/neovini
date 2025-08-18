-- ~/.config/nvim/lua/plugins/lsp/init.lua
return {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim'},
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Função a ser executada quando o LSP se anexa a um buffer
        local on_attach = function(client, bufnr)
            local keymap = vim.keymap.set
            -- Define as opções para os atalhos deste buffer
            -- noremap=true: não permite que o atalho seja remapeado recursivamente
            -- silent=true: não mostra o comando no rodapé ao ser executado
            local opts = {
                buffer = bufnr,
                noremap = true,
                silent = true
            }

            -- Mapeamentos do LSP
            keymap('n', 'gD', vim.lsp.buf.declaration, opts)
            keymap('n', 'gd', vim.lsp.buf.definition, opts)
            keymap('n', 'K', vim.lsp.buf.hover, opts)
            keymap('n', 'gi', vim.lsp.buf.implementation, opts)
            keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            keymap('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            keymap('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
            keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)

            -- MAPEAMENTO CORRETO E EXPLÍCITO PARA 'GO TO REFERENCES'
            keymap('n', 'gr', vim.lsp.buf.references, opts)

            keymap('n', '<leader>f', function()
                vim.lsp.buf.format({
                    async = true
                })
                vim.notify("Código formatado!", vim.log.levels.INFO, {
                    title = "NeoVini"
                })
            end, opts)
        end

        -- Configura o C# Language Server (csharp-ls)
        lspconfig.csharp_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities
        })

        -- Configura o Lua Language Server para a própria config do Neovim
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'}
                    }
                }
            }
        })
    end
}
