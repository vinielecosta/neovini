require('gitsigns').setup({
    ---
    -- Title: Visual Signals
    ---
    -- Defines the icons that will appear in the gutter for each type of change.
    -- Requires a Nerd Font to display correctly.
    signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '▎' },
    },
    ---
    -- Title: Keyboard Shortcuts (on_attach)
    ---
    -- Function that is executed for each file that gitsigns "attaches" to.
    -- This is the ideal place to define the plugin's keyboard shortcuts.
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local keymap = vim.keymap.set

        -- Default options for shortcuts (apply only to this buffer)
        local opts = { buffer = bufnr }

        ---
        -- Subtitle: Navigating Between Changes (Hunks)
        ---
        -- Allows quickly jumping between blocks of code that were changed
        keymap('n', ']h', function() gs.next_hunk() end, opts)
        keymap('n', '[h', function() gs.prev_hunk() end, opts)

        ---
        -- Subtitle: Actions on Hunks
        ---
        -- Allows staging or resetting specific code blocks
        keymap('n', '<leader>hs', gs.stage_hunk, opts) -- Stage current hunk
        keymap('n', '<leader>hr', gs.reset_hunk, opts) -- Reset changes in current hunk
        -- Same actions, but for a Visual Mode selection
        keymap('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
        keymap('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)

        ---
        -- Subtitle: Actions on Entire File (Buffer)
        ---
        keymap('n', '<leader>hS', gs.stage_buffer, opts) -- Stage all changes in file
        keymap('n', '<leader>hR', gs.reset_buffer, opts) -- Reset all changes in file

        ---
        -- Subtitle: View Actions
        ---
        -- Shows changes of current hunk in a floating window
        keymap('n', '<leader>hp', gs.preview_hunk, opts)
        -- Shows who made the change in the current line (git blame)
        keymap('n', '<leader>hb', function() gs.blame_line({ full = true }) end, opts)
    end,
})
