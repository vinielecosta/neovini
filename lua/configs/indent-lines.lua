require('ibl').setup({
    indent = {
        char = '┊',
    },
    scope = {
        show_start = false,
        show_end = false,
        show_exact_scope = true,
    },
    exclude = {
        buftypes = { 'terminal', 'nofile' },
        filetypes = {
            'help',
            'packer',
            'NvimTree',
        },
    },
})
