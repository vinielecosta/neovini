require('lualine').setup({
    options = {
        -- IMPORTANT: Change the theme here to match the active theme.
        -- Options: 'dracula', 'tokyonight', 'catppuccin', 'gruvbox', 'github', 'kanagawa'.
        theme = 'onedark'
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    }
})
