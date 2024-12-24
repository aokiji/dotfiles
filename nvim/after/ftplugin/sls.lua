local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_option(buf, "expandtab", true)
vim.api.nvim_buf_set_option(buf, "shiftwidth", 2)
vim.api.nvim_buf_set_option(buf, "tabstop", 2)
