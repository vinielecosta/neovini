local keymap = vim.keymap.set

----------------------------------------------------------------------
-- NORMAL MODE (n)
----------------------------------------------------------------------

keymap('n', '<C-s>', ':w<CR>', {
    desc = 'Save file'
})

keymap('n', '<C-h>', '<C-w>h', {
    desc = 'Move to left window'
})
keymap('n', '<C-j>', '<C-w>j', {
    desc = 'Move to bottom window'
})
keymap('n', '<C-k>', '<C-w>k', {
    desc = 'Move to top window'
})
keymap('n', '<C-l>', '<C-w>l', {
    desc = 'Move to right window'
})

keymap('n', '<C-Up>', ':resize +2<CR>', {
    desc = 'Increase window height'
})
keymap('n', '<C-Down>', ':resize -2<CR>', {
    desc = 'Decrease window height'
})
keymap('n', '<C-Left>', ':vertical resize -2<CR>', {
    desc = 'Decrease window width'
})
keymap('n', '<C-Right>', ':vertical resize +2<CR>', {
    desc = 'Increase window width'
})

keymap('n', '<leader>q', ':q<CR>', {
    desc = 'Close current buffer'
})

keymap('n', '<leader>tt', function()
    require('core.dotnet.dotnet-test').run_tests()
end, {
    desc = '.NET: Run project tests'
})

keymap('n', '<leader>rp', function()
    require('core.dotnet.dotnet-run').run_project()
end, {
    desc = '.NET: Run specific project'
})

keymap('n', '<leader>na', function()
    require('core.dotnet.add-package').add_package_directly()
end, {
    desc = 'NuGet: Add package directly'
})

keymap('n', '<leader>pr', function()
    require('core.dotnet.add-reference').add_project_reference()
end, {
    desc = '.NET: Add project reference'
})

keymap('n', '<leader>dn', function()
    require('core.dotnet.dotnet-new').create_project()
end, {
    desc = '.NET: Create new project'
})

keymap('n', '<leader>s', function()
    require('core.functions.find_replace').find_and_replace()
end, {
    desc = 'Find and Replace in file'
})

keymap('n', '<leader>z', ':ZenMode<CR>', {
    desc = 'Enable Zen mode'
})

keymap('n', '<leader>tw', ':Twilight<CR>', {
    desc = 'Enable Twilight mode'
})

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {
    desc = 'Open/Close File Explorer'
})

keymap('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic'
})
keymap('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic'
})

keymap('n', 'gD', vim.lsp.buf.declaration, {
    desc = 'LSP: Go to declaration'
})
keymap('n', 'gd', vim.lsp.buf.definition, {
    desc = 'LSP: Go to definition'
})
keymap('n', 'K', vim.lsp.buf.hover, {
    desc = 'LSP: Show hover documentation'
})
keymap('n', 'gi', vim.lsp.buf.implementation, {
    desc = 'LSP: Go to implementation'
})

keymap('n', '<leader>ca', function()
    vim.cmd('write')
    vim.lsp.buf.code_action()
end, {
    desc = 'LSP: Show code actions'
})

keymap('n', 'gr', vim.lsp.buf.references, {
    desc = 'LSP: Show references'
})
keymap('n', '<leader>rn', vim.lsp.buf.rename, {
    desc = 'LSP: Rename symbol'
})
keymap('n', '<leader>ft', function()
    vim.lsp.buf.format({
        async = true
    })
end, {
    desc = 'LSP: Format code'
})

keymap('n', '<leader>rr', function()
    vim.cmd('Roslyn restart')
end, {
    desc = 'LSP: Restart Roslyn Server'
})

keymap("n", "<leader>jf", '<cmd>JsonFormatFile<cr>', {
    desc = 'JSON: Format file'
})
keymap("n", "<leader>jmf", '<cmd>JsonMinifyFile<cr>', {
    desc = 'JSON: Minify file'
})

keymap('n', '<leader>vt', '<Cmd>ToggleTerm direction=vertical<CR>', {
    desc = 'Toggle terminal vertically'
})

keymap('n', '<leader>ht', '<Cmd>ToggleTerm direction=horizontal<CR>', {
    desc = 'Toggle terminal horizontally'
})

keymap('n', '<C-a>', '<Cmd>Alpha<CR>', {
    desc = 'Show Alpha'
})

keymap('n', '<leader>tw', ':Twilight<CR>', {
    desc = 'Twilight mode'
})

----------------------------------------------------------------------
-- VISUAL MODE (v)
----------------------------------------------------------------------

keymap('v', '<', '<gv', {
    desc = 'Indent left (keep selection)'
})
keymap('v', '>', '>gv', {
    desc = 'Indent right (keep selection)'
})

----------------------------------------------------------------------
-- INSERT MODE (i)
----------------------------------------------------------------------

keymap('i', 'jk', '<ESC>', {
    desc = 'Exit insert mode'
})

keymap('i', '<C-H>', '<C-W>', {
    noremap = true,
    desc = 'Binding delete on "Ctrl + Backspace'
})

keymap('i', '<C-Right>', '<Esc>ea', {
    desc = 'Move to end of word'
})
keymap('i', '<C-Left>', '<Esc>bi', {
    desc = 'Move to beginning of word'
})

----------------------------------------------------------------------
-- TERMINAL MODE (t)
----------------------------------------------------------------------

keymap('t', '<C-t>', '<Cmd>ToggleTerm<CR>', {
    desc = 'Hide terminal'
})

