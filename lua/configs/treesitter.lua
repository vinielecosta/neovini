require('nvim-treesitter.configs').setup({
    ---
    -- Title: Parser Management
    ---
    -- List of language parsers that should be guaranteed as installed.
    ensure_installed = { 'c_sharp', 'lua', 'vim', 'vimdoc', 'json', 'bash', 'markdown' },
    -- Install parsers asynchronously to not block startup.
    sync_install = false,
    -- Automatically install new parsers for languages you open, if not yet installed.
    auto_install = true,

    ---
    -- Title: Treesitter Modules
    ---
    -- Enables the syntax highlighting module.
    highlight = {
        enable = true,
    },
    -- Enables the indentation module, which helps indent code more precisely.
    indent = {
        enable = true,
    },
})
