-- ~/.config/nvim/lua/plugins/lsp/init.lua
-- Este ficheiro configura o cliente LSP (Language Server Protocol) do Neovim.
-- Ele é o cérebro por trás de funcionalidades como autocompletar, ir para a definição,
-- ver referências e diagnósticos de erros em tempo real.

return {
  -- O plugin principal para a configuração do LSP.
  'neovim/nvim-lspconfig',
  -- Dependências: Garante que o mason.nvim (gerenciador de servidores) seja carregado.
  dependencies = { 'williamboman/mason.nvim' },
  -- A função de configuração principal do plugin.
  config = function()
    local lspconfig = require('lspconfig')

    ----------------------------------------------------------------------
    -- CAPACIDADES DO CLIENTE
    ----------------------------------------------------------------------
    -- Define as "capacidades" que o nosso cliente Neovim suporta.
    -- Isto informa ao servidor de linguagem (ex: csharp_ls) o que o nosso editor consegue fazer.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- Correção para o aviso de 'positionEncoding': define explicitamente o padrão
    -- que o servidor C# espera, garantindo a comunicação correta.
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { "utf-16" }

    ----------------------------------------------------------------------
    -- FUNÇÃO ON_ATTACH
    ----------------------------------------------------------------------
    -- Esta função é executada para cada ficheiro que um servidor LSP "anexa".
    -- É o local ideal para definir atalhos e automações específicas do LSP.
    local on_attach = function(client, bufnr)
      local keymap = vim.keymap.set
      -- Opções padrão para os atalhos do LSP (aplicam-se apenas a este buffer).
      local opts = {
        buffer = bufnr,
        noremap = true,
        silent = true,
      }

      ---
      -- Título: Atalhos de Navegação e Informação do Código
      ---
      keymap('n', 'gD', vim.lsp.buf.declaration, opts)     -- Ir para a declaração
      keymap('n', 'gd', vim.lsp.buf.definition, opts)      -- Ir para a definição
      keymap('n', 'K', vim.lsp.buf.hover, opts)             -- Mostrar documentação (hover)
      keymap('n', 'gi', vim.lsp.buf.implementation, opts)  -- Ir para a implementação
      keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Mostrar ajuda da assinatura da função

      ---
      -- Título: Atalhos de Refatoração e Ações de Código
      ---
      keymap('n', '<leader>rn', ':IncRename ', opts)        -- Renomeação interativa
      keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Ver ações de código disponíveis
      keymap('n', 'gr', function()                         -- Ver referências com Telescope
        require('telescope.builtin').lsp_references()
      end, opts)
      keymap('n', '<leader>f', function()                  -- Formatar o ficheiro
        vim.lsp.buf.format({ async = true })
        vim.notify("Código formatado!", vim.log.levels.INFO, { title = "NeoVini" })
      end, opts)

      ---
      -- Título: Automação ao Salvar
      ---
      -- Se o servidor suportar, organiza automaticamente as diretivas 'using' ao salvar.
      if client.supports_method("textDocument/codeAction") then
        local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
          end,
        })
      end
    end

    ----------------------------------------------------------------------
    -- CONFIGURAÇÃO DOS SERVIDORES DE LINGUAGEM
    ----------------------------------------------------------------------

    ---
    -- Título: Servidor C# (.NET)
    ---
    lspconfig.csharp_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    ---
    -- Título: Servidor Lua (para a nossa própria configuração)
    ---
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            -- Informa ao servidor que 'vim' é uma variável global válida.
            globals = { 'vim' },
          },
        },
      },
    })
  end,
}
