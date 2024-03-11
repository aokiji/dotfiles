return {
  { -- Useful status updates for LSP
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', opts = {} },
    opts = {
      servers = {
        perlnavigator = {
          settings = {
            perlnavigator = {
              logging = true,
              perltidyEnabled = true,
              perlimportsLintEnabled = true,
              perlimportsTidyEnabled = false
            }
          }
        },
        lua_ls = { settings = { Lua = { diagnostics = { globals = { 'vim' } }, workspace = { checkThirdParty = false }, telemetry = { enable = false } } } },
        jedi_language_server = { init_options = { workspace = { environmentPath = '/opt/pyenv/shims/python' } } },
        pylyzer = { settings = {} },
        ruff_lsp = {
          init_options = { settings = { path = { '/opt/pyenv/shims/ruff' }, interpreter = { '/opt/pyenv/shims/python' } } }
        }
      },
      --  This function gets run when an LSP connects to a particular buffer.
      on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
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
      end
    },
    config = function(_, opts)
      local mason_lspconfig = require('mason-lspconfig')
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup { ensure_installed = vim.tbl_keys(opts.servers) }
      mason_lspconfig.setup_handlers {
        function(server_name)
          local server_config = { capabilities = capabilities, on_attach = opts.on_attach }
          local server_opts = opts.servers[server_name]
          if (server_opts ~= nil) then for k, v in pairs(opts.servers[server_name]) do server_config[k] = v end end
          require('lspconfig')[server_name].setup(server_config)
        end
      }
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',                                                                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      'williamboman/mason-lspconfig.nvim', { 'j-hui/fidget.nvim', opts = {}, branch = 'legacy' }, -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {} }
    }
  }
}
