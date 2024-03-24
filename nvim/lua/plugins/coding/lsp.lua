local on_lsp_attach = function(_, bufnr)
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
end

return {
  { -- Useful status updates for LSP
    'williamboman/mason-lspconfig.nvim',
    dependencies = { { 'williamboman/mason.nvim', opts = {} }, 'nanotee/sqls.nvim' },
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
        lua_ls = { settings = {} },
        jedi_language_server = { init_options = { workspace = { environmentPath = '/opt/pyenv/shims/python' } } },
        pylyzer = { settings = {} },
        ruff_lsp = {
          init_options = { settings = { path = { '/opt/pyenv/shims/ruff' }, interpreter = { '/opt/pyenv/shims/python' } } }
        },
        clangd = {},
        gopls = {
          root_dir = function(fname)
            local util = require 'lspconfig.util'
            -- see: https://github.com/neovim/nvim-lspconfig/issues/804
            local mod_cache = vim.trim(vim.fn.system 'go env GOMODCACHE')
            if fname:sub(1, #mod_cache) == mod_cache then
              local clients = vim.lsp.get_active_clients { name = 'gopls' }
              if #clients > 0 then
                return clients[#clients].config.root_dir
              end
            end
            return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
          end,
        },
        sqls = {
          cmd = { vim.fn.expand('~/workspace/sqls/sqls'), '-l', '/tmp/sqls.log' },
          init_options = {
            connectionConfig = {
              alias = 'pg_local',
              driver = 'postgresql',
              dataSourceName = 'postgres://eolica@localhost:5432/eolica'
            }
          },
          on_attach = function(client, bufnr)
            on_lsp_attach(client, bufnr)

            vim.keymap.set('n', '<leader>ce', '<cmd>SqlsExecuteQuery<cr>', { buffer = bufnr, desc = '[E]xecute Query' })
            require('sqls').on_attach(client, bufnr)
          end
        }
      },
      --  This function gets run when an LSP connects to a particular buffer.
      on_attach = on_lsp_attach
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

      -- uncomment the following line to see debug information from lsp 
      -- vim.lsp.set_log_level('debug')
    end
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {}, branch = 'legacy' } -- Additional lua configuration, makes nvim stuff amazing!
    }
  },
  {
    'nvimtools/none-ls.nvim',
    event = 'VeryLazy',
    config = function()
      local null_ls = require('null-ls')

      local helpers = require("null-ls.helpers")
      local methods = require("null-ls.methods")

      local FORMATTING = methods.internal.FORMATTING

      local add_missing_perl_includes = helpers.make_builtin({
        name = "add_missing_includes_perl",
        method = FORMATTING,
        filetypes = { "perl", "pm" },
        generator_opts = {
          command = "add_missing_includes_perl",
          to_stdin = true,
        },
        factory = helpers.formatter_factory,
      })

      local sources = {
        null_ls.builtins.formatting.pg_format.with({
          extra_filetypes = { 'pg' },
          extra_args = { '-W', '10', '-w', '120' }
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt,
        add_missing_perl_includes
      }

      null_ls.setup({ sources = sources, on_attach = on_lsp_attach })
    end
  }
}
