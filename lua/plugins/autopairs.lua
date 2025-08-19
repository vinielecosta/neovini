-- ~/.config/nvim/lua/plugins/autopairs.lua
-- Este ficheiro configura o nvim-autopairs, um plugin que insere
-- automaticamente o par correspondente de parênteses, chavetas, aspas, etc.

return {
  'windwp/nvim-autopairs',
  -- O evento 'InsertEnter' garante que o plugin seja carregado de forma preguiçosa,
  -- apenas na primeira vez que você entra no modo de inserção.
  event = "InsertEnter",
  config = function()
    local autopairs = require('nvim-autopairs')
    
    ---
    -- Título: Configuração Principal
    ---
    autopairs.setup({
      -- Ativa a verificação com o Treesitter para evitar adicionar pares
      -- em locais inadequados (ex: dentro de uma string ou comentário).
      check_ts = true,
      -- Configurações específicas para certas linguagens com Treesitter.
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      },
    })

    ---
    -- Título: Integração com nvim-cmp
    ---
    -- Esta secção é crucial para garantir que o autopairs não interfira
    -- com o comportamento do menu de autocompletar (nvim-cmp).
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    -- Garante que, ao confirmar uma sugestão do cmp, o autopairs se comporte corretamente.
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
