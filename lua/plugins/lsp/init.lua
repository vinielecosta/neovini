-- ~/.config/nvim/lua/plugins/lsp/init.lua
return {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim'},
    config = function()
        local lspconfig = require('lspconfig')

        -- CAPACIDADES ATUALIZADAS (MÉTODO MAIS ROBUSTO)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities.general = capabilities.general or {}
        capabilities.general.positionEncodings = {"utf-16"}

        local on_attach = function(client, bufnr)
            local keymap = vim.keymap.set
            local opts = {
                buffer = bufnr,
                noremap = true,
                silent = true
            }

            keymap('n', 'gD', vim.lsp.buf.declaration, opts)
            keymap('n', 'gd', vim.lsp.buf.definition, opts)
            keymap('n', 'K', vim.lsp.buf.hover, opts)
            keymap('n', 'gi', vim.lsp.buf.implementation, opts)
            keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            keymap('n', '<leader>rn', ':IncRename ', opts)
            keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)

            keymap('n', 'gr', function()
                require('telescope.builtin').lsp_references()
            end, opts)

            keymap('n', '<leader>f', function()
                vim.lsp.buf.format({
                    async = true
                })
                vim.notify("Código formatado!", vim.log.levels.INFO, {
                    title = "NeoVini"
                })
            end, opts)

            if client.supports_method("textDocument/codeAction") then
                local augroup = vim.api.nvim_create_augroup('LspFormatting', {
                    clear = true
                })
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.code_action({
                            context = {
                                only = {"source.organizeImports"}
                            },
                            apply = true
                        })
                    end
                })
            end
        end

        lspconfig.csharp_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities
        })

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
