-- ~/.config/nvim/lua/plugins/autocompletion.lua
-- Este ficheiro configura o nvim-cmp, o motor de autocompletar.
-- Ele é responsável por mostrar as sugestões de código enquanto você digita.

return {
  'hrsh7th/nvim-cmp',
  -- Dependências: Outros plugins que fornecem "fontes" de sugestões para o nvim-cmp.
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- Sugestões do Language Server (IntelliSense).
    'hrsh7th/cmp-buffer',   -- Sugestões baseadas no texto de outros ficheiros abertos.
    'hrsh7th/cmp-path',     -- Sugestões de caminhos de ficheiro.
    'L3MON4D3/LuaSnip',     -- O motor para os snippets de código.
    'saadparwaiz1/cmp_luasnip', -- Integração entre o LuaSnip e o nvim-cmp.
    'rafamadriz/friendly-snippets', -- Uma vasta coleção de snippets prontos a usar.
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    -- Carrega os snippets da coleção 'friendly-snippets' para que possam ser utilizados.
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      ---
      -- Título: Integração com Snippets
      ---
      -- Define como o nvim-cmp deve expandir os snippets.
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      ---
      -- Título: Atalhos de Teclado (Mappings)
      ---
      -- Define os atalhos para interagir com o menu de autocompletar.
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Rola a documentação para cima.
        ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Rola a documentação para baixo.
        ['<C-Space>'] = cmp.mapping.complete(),      -- Mostra as sugestões de autocompletar.
        ['<C-e>'] = cmp.mapping.abort(),             -- Fecha o menu de autocompletar.
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirma a seleção.

        -- Tab para navegar e expandir snippets.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Se o menu estiver visível, seleciona o próximo item.
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- Se houver um snippet para expandir, expande-o.
          else
            fallback() -- Caso contrário, executa a ação padrão do Tab.
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Se o menu estiver visível, seleciona o item anterior.
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1) -- Se estiver dentro de um snippet, salta para o ponto anterior.
          else
            fallback() -- Caso contrário, executa a ação padrão do Shift+Tab.
          end
        end, { 'i', 's' }),
      }),
      ---
      -- Título: Fontes de Sugestões (Sources)
      ---
      -- Define de onde o nvim-cmp deve obter as suas sugestões.
      sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- Sugestões do LSP.
        { name = 'luasnip' },  -- Sugestões de snippets.
        { name = 'buffer' },   -- Sugestões do texto nos buffers abertos.
        { name = 'path' },     -- Sugestões de caminhos de ficheiro.
      }),
    })
  end,
}
