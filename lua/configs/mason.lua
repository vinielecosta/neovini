-- lua/configs/mason.lua

-- Inicializa o Mason (gerenciador de LSPs, linters, etc.)
require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- lspconfig.lua

-- Inicializa o mason-lspconfig, a ponte entre o Mason e o lspconfig
require('mason-lspconfig').setup({
    -- Lista de servidores que o Mason deve garantir que estejam instalados
    ensure_installed = {
        'lua_ls',"biome"
    },
    automatic_enable = {
        "lua_ls",
        "roslyn,"
    }
})



