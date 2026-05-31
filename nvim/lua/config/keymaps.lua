-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- quick exit from insert mode
vim.keymap.set('i', 'jj', '<esc>')

-- jump to next command
vim.keymap.set({ 'n', 'v' }, ']c', '/^❯<CR>', { desc = "jump next command" })
vim.keymap.set({ 'n', 'v' }, '[c', '?^❯<CR>', { desc = "jump previous command" })

-- git worktree add
vim.keymap.set({ 'n', 'v' }, '<leader>ga', vim.cmd.GitWorktreeAdd, { desc = "Git Worktree Add" })

-- copy file paths
vim.keymap.set({ 'n', 'v' }, '<leader>cp', vim.cmd.CopyRelativePath, { desc = "Copy Relative File Path" })
vim.keymap.set({ 'n', 'v' }, '<leader>cP', vim.cmd.CopyAbsolutePath, { desc = "Copy Absolute File Path" })

vim.keymap.set({ 'n', 'v' }, '<leader><leader>', "<C-^>", { desc = "Back to previous buffer" })
vim.keymap.set({ 'n', 'v' }, '<leader>xs', vim.diagnostic.open_float, { desc = "Buffer Diagnostics" })
