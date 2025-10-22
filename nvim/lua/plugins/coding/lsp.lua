return {
  { -- Useful status updates for LSP
    'williamboman/mason-lspconfig.nvim',
    dependencies = { { 'williamboman/mason.nvim', opts = {} }, 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'perlnavigator', 'cmake', 'dockerls', 'docker_compose_language_service', 'pyright', 'clangd',
        'yamlls', 'lua_ls', 'postgres_lsp', 'groovyls', 'sqruff'
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {}, branch = 'legacy' } -- Additional lua configuration, makes nvim stuff amazing!
    },
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
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.saltlint.with({
          command = vim.fn.expand("~/.venv/tools/bin/salt-lint")
        }),
        add_missing_perl_includes
      }

      null_ls.setup({ sources = sources })
    end
  }
}
