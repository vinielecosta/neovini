-- ~/.config/nvim/lua/plugins/mason.lua
-- Este ficheiro configura o mason.nvim e as suas extensões.
-- O Mason é um gerenciador de pacotes que automatiza a instalação de
-- servidores de linguagem (LSP), depuradores (DAP), linters e formatadores,
-- garantindo que as ferramentas de desenvolvimento estejam sempre disponíveis.

return {
  'williamboman/mason.nvim',
  -- Dependências: Garante que a ponte entre o Mason e o lspconfig seja carregada.
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    ---
    -- Título: Configuração Principal do Mason
    ---
    -- Inicializa o Mason com as suas configurações padrão.
    require('mason').setup()

    ---
    -- Título: Integração com o LSPConfig
    ---
    -- Configura o mason-lspconfig para gerir os servidores de linguagem.
    require('mason-lspconfig').setup({
      -- Lista de servidores que o Mason deve garantir que estejam sempre instalados.
      -- Se um servidor desta lista não estiver instalado, o Mason irá instalá-lo
      -- automaticamente na próxima vez que o Neovim for iniciado.
      ensure_installed = {
        'csharp_ls', -- O Language Server principal para C# e .NET.
        'lua_ls',    -- O Language Server para Lua (útil para configurar o próprio Neovim).
      },
    })
  end,
}
