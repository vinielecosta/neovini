return {
    'williamboman/mason.nvim',
    dependencies = {'williamboman/mason-lspconfig.nvim'},
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {'csharp_ls', -- O Language Server para C#
            'lua_ls'}
        })
    end
}
