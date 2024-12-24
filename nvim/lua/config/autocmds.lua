-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost',
                            {callback = function() vim.highlight.on_yank() end, group = highlight_group, pattern = '*'})

-- set sls files filetype to yaml
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.sls',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "yaml")
    vim.api.nvim_buf_set_option(buf, "expandtab", true)
    vim.api.nvim_buf_set_option(buf, "shiftwidth", 2)
    vim.api.nvim_buf_set_option(buf, "tabstop", 2)
  end
})

-- set Jenkinsfile filetype to groovy
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.Jenkinsfile',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, "filetype", "groovy")
    vim.api.nvim_buf_set_option(buf, "expandtab", true)
    vim.api.nvim_buf_set_option(buf, "shiftwidth", 4)
    vim.api.nvim_buf_set_option(buf, "tabstop", 4)
  end
})
