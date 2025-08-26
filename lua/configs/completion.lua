local cmp = require('cmp')
local luasnip = require('luasnip')
-- Load snippets from 'friendly-snippets' collection
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    ---
    -- Title: Snippet Integration
    ---
    -- Define how nvim-cmp should expand snippets
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    ---
    -- Title: Keyboard Shortcuts (Mappings)
    ---
    -- Define shortcuts to interact with the autocomplete menu
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Tab to navigate and expand snippets
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    -- Formatting to use neokinds icons
    formatting = {
        format = require('neokinds').menu,
    },
    ---
    -- Title: Suggestion Sources
    ---
    -- Define where nvim-cmp should get its suggestions
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP suggestions
        { name = 'luasnip' },  -- Snippet suggestions
        { name = 'buffer' },   -- Suggestions from open buffers
        { name = 'path' },     -- File path suggestions
    }),
})
