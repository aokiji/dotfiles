-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost',
                            {callback = function() vim.highlight.on_yank() end, group = highlight_group, pattern = '*'})

-- set sls files filetype to yaml
vim.api.nvim_create_autocmd({'BufNewFile','BufRead'}, { pattern = '*.sls', callback = function() vim.bo.filetype = 'yaml' end})
