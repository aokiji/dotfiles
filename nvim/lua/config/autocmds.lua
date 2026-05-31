-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost',
                            { callback = function() vim.highlight.on_yank() end, group = highlight_group, pattern = '*' })

-- cuando mantengamos el cursor si hay un diagnostico lo mostramos
vim.api.nvim_create_autocmd("CursorHold", {
                            group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
                            pattern = "*",
                            callback = function()
                                                        vim.diagnostic.open_float(nil, { focusable = false })
                            end
})
