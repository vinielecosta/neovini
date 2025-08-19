-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Este ficheiro configura o nvim-treesitter, um plugin que melhora drasticamente
-- a análise e o destaque de sintaxe do Neovim. Ele usa "parsers" de linguagens
-- para entender a estrutura do código de forma mais inteligente do que as
-- expressões regulares tradicionais, resultando num highlighting mais preciso e rápido.

return {
  'nvim-treesitter/nvim-treesitter',
  -- O comando 'build' garante que os parsers sejam compilados e atualizados
  -- sempre que o plugin for atualizado.
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ---
      -- Título: Gestão de Parsers
      ---
      -- Lista de parsers de linguagens que devem ser garantidos como instalados.
      ensure_installed = { 'c_sharp', 'lua', 'vim', 'vimdoc', 'json', 'bash', 'markdown' },
      -- Instala os parsers de forma assíncrona para não bloquear o arranque.
      sync_install = false,
      -- Instala automaticamente novos parsers para linguagens que você abrir, se ainda não estiverem instalados.
      auto_install = true,

      ---
      -- Título: Módulos do Treesitter
      ---
      -- Ativa o módulo de destaque de sintaxe (highlighting).
      highlight = {
        enable = true,
      },
      -- Ativa o módulo de indentação, que ajuda a indentar o código de forma mais precisa.
      indent = {
        enable = true,
      },
    })
  end,
}
