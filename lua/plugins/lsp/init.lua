-- ~/.config/nvim/lua/plugins/lsp/init.lua
-- Este ficheiro configura o cliente LSP (Language Server Protocol) do Neovim.
-- Ele é o cérebro por trás de funcionalidades como autocompletar, ir para a definição,
-- ver referências e diagnósticos de erros em tempo real.
return {
    'neovim/nvim-lspconfig',
    dependencies = {'williamboman/mason.nvim'},
    config = function()
        ---
        -- Título: Sinais de Diagnóstico (Ícones)
        ---
        -- Corrige um aviso de "deprecated" ao definir explicitamente os ícones
        -- para erros, avisos, etc., usando a API moderna do Neovim.

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.INFO] = ""
                }
            }
        })

        ---
        -- Título: Capacidades do Cliente LSP
        ---
        -- Define as "capacidades" que o nosso cliente Neovim suporta.
        -- Isto informa ao servidor de linguagem (ex: csharp_ls) o que o nosso editor consegue fazer.
        local lspconfig = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities.general = capabilities.general or {}
        capabilities.general.positionEncodings = {"utf-16"} -- Essencial para C#

        ---
        -- Título: Função on_attach
        ---
        -- Esta função é executada para cada ficheiro que um servidor LSP "anexa".
        -- É o local ideal para definir atalhos e automações específicas do LSP.
        local on_attach = function(client, bufnr)
            local keymap = vim.keymap.set
            local opts = {
                buffer = bufnr,
                noremap = true,
                silent = true
            }

            -- Atalhos de Navegação e Informação
            keymap('n', 'gD', vim.lsp.buf.declaration, opts)
            keymap('n', 'gd', vim.lsp.buf.definition, opts)
            keymap('n', 'K', vim.lsp.buf.hover, opts)
            keymap('n', 'gi', vim.lsp.buf.implementation, opts)
            keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)

            -- Atalhos de Refatoração e Ações
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

            -- Automação: Organizar 'usings' ao salvar
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

        ---
        -- Título: Configuração dos Servidores de Linguagem
        ---
        -- Servidor C# (.NET)
        lspconfig.csharp_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities
        })

        -- Servidor Lua (para a nossa própria configuração)
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
