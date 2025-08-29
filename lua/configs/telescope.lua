local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        -- Default configuration
        -- prompt_prefix = "   ",
        -- selection_caret = "  ",
        -- entry_prefix = "  ",
        initial_mode = "insert",
        -- selection_strategy = "reset",
        -- sorting_strategy = "ascending",
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --     horizontal = {
        --         prompt_position = "top",
        --         preview_width = 0.55,
        --         results_width = 0.8,
        --     },
        --     vertical = {
        --         mirror = false,
        --     },
        --     width = 0.87,
        --     height = 0.80,
        --     preview_cutoff = 120,
        -- },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<CR>"] = actions.select_default,
                -- ["<C-x>"] = actions.select_vertical,
                ["<C-x>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                -- ["<C-x>"] = actions.select_horizontal,
                ["<C-x>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom
            }
        }
    }
    -- pickers = {
    --     find_files = {
    --         theme = "dropdown",
    --         previewer = false,
    --         hidden = true,
    --     },
    --     live_grep = {
    --         theme = "dropdown",
    --     },
    --     buffers = {
    --         theme = "dropdown",
    --         previewer = false,
    --     },
    -- },
    -- extensions = {
    --     file_browser = {
    --         theme = "dropdown",
    --         previewer = false,
    --         hidden = true,
    --     },
    -- },
})

-- Load extensions if installed
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "file_browser")

-- Keybindings
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', {
    noremap = true,
    silent = true
})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
