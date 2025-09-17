vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local nmap = function(keys, func, desc)
      if desc then desc = 'LSP: ' .. desc end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    nmap('<leader>ld', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>ls', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('<leader>ll', '<cmd>LspLog<cr>', 'Open [L]sp [L]og')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end,
      { desc = 'Format current buffer with LSP' })
    nmap('<leader>f', function() vim.lsp.buf.format { async = true } end, '[F]format file')
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', { capabilities = capabilities })
vim.lsp.enable({ 'jedi_language_server', 'ruff' })
