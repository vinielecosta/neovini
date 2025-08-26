require('toggleterm').setup({
    -- Terminal window settings
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    -- Style settings
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    -- Float settings
    float_opts = {
        border = 'curved',
        width = function() return math.floor(vim.o.columns * 0.85) end,
        height = function() return math.floor(vim.o.lines * 0.8) end,
        winblend = 3,
    },
})

-- Terminal keybindings
vim.keymap.set('n', '<C-t>', '<Cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Toggle terminal horizontally' })
vim.keymap.set('n', '<C-\\>', '<Cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { desc = 'Hide terminal' })
vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><Cmd>ToggleTerm<CR>', { desc = 'Hide terminal' })
