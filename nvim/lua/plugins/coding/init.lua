return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require('project_nvim').setup()
      require('telescope').load_extension('projects')
      vim.keymap.set('n', '<leader>sp', require 'telescope'.extensions.projects.projects, { desc = '[Search] [P]rojets' })
    end
  },
  -- Git related plugins
  {
    'tpope/vim-fugitive',
    cmd = { 'Git' },
    keys = {
      { '<leader>gb', "<cmd>Git blame<cr>",               desc = "Git blame" },
      { '<leader>B',  "<cmd>Git blame<cr>",               desc = "Git blame" },
      { '<leader>gs', "<cmd>Git<cr>",                     desc = "Git status" },
      { '<leader>gl', "<cmd>Git log %<cr>",               desc = "Show git log of current file" },
      { '<leader>gp', "<cmd>Git push -u origin HEAD<cr>", desc = "Git push" },
      { '<leader>gP', "<cmd>Git push --force<cr>",        desc = "Git force push" },
      { '<leader>gu', "<cmd>GitlabURL<cr>",               desc = "Open file in Gitlab" },
      { '<leader>U',  "<cmd>GitlabURL<cr>",               desc = "Open file in Gitlab" },
      { '<leader>go', "<cmd>GitlabOpenMerge<cr>",         desc = "Open merge in Gitlab" },
    }
  },
  {
    -- Open browser in github
    'tpope/vim-rhubarb',
    cmd = { 'GBrowse' }
  },

  { -- Adds Git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' }
      }
    }
  }, -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim', opts = {}
  },
  {
    -- handling paired characters in various filetypes
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    -- Snippets engine
    'L3MON4D3/LuaSnip',
    opts = {},
    config = function(_, opts)
      require('luasnip').setup(opts)
      require("luasnip.loaders.from_lua").load()
    end
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer' },
    opts = function()
      -- nvim-cmp setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      cmp.setup {
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' })
        },
        sources = { { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'commits' }, { name = 'buffer' } }
      }
    end
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim', 'perl' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>'
        }
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner'
          }
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
          goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
          goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
          goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' }
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>a'] = '@parameter.inner' },
          swap_previous = { ['<leader>A'] = '@parameter.inner' }
        }
      }
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
  },                                              -- symbols outline
  { 'simrat39/symbols-outline.nvim', opts = {} }, -- running tests
  { 'kylechui/nvim-surround',        opts = {} }, {
  'klen/nvim-test',
  opts = {
    termOpts = { direction = 'horizontal', height = 10 },
    runners = {
      perl = 'nvim-test-perl-runner', -- custom
      cs = "nvim-test.runners.dotnet",
      go = "nvim-test.runners.go-test",
      haskell = "nvim-test.runners.hspec",
      javascriptreact = "nvim-test.runners.jest",
      javascript = "nvim-test.runners.jest",
      lua = "nvim-test.runners.busted",
      python = "nvim-test.runners.pytest",
      ruby = "nvim-test.runners.rspec",
      rust = "nvim-test.runners.cargo-test",
      typescript = "nvim-test.runners.jest",
      typescriptreact = "nvim-test.runners.jest"
    }
  }
}, -- debugger adapters (dap)
  {
    'mfussenegger/nvim-dap',
    opts = {
      adapters = { perlsp = { type = 'server', host = '127.0.0.1', port = '27011' } },
      configurations = {
        perl = {
          {
            name = 'Launch Perl',
            type = 'perlsp',
            request = 'launch',
            program = "${workspaceFolder}/${relativeFile}",
            reloadModules = true,
            stopOnEntry = false,
            cwd = "${workspaceFolder}"
          }
        }
      }
    },
    config = function(_, opts)
      local dap = require('dap')

      vim.keymap.set('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>")
      vim.keymap.set('n', '<F6>', "<Cmd>lua require'dap'.step_over()<CR>")
      vim.keymap.set('n', '<F7>', "<Cmd>lua require'dap'.step_into()<CR>")
      vim.keymap.set('n', '<F10>', "<Cmd>lua require'dap'.step_out()<CR>")

      if (opts.adapters ~= nil) then
        for adapter, adapter_config in pairs(opts.adapters) do dap.adapters[adapter] = adapter_config end
      end

      if (opts.configurations ~= nil) then
        for language, configuration in pairs(opts.configurations) do dap.configurations[language] = configuration end
      end
    end
  }, { "rcarriga/nvim-dap-ui",  requires = { "mfussenegger/nvim-dap" }, opts = {} }, { 'ludovicchabant/vim-gutentags' },
  { import = 'plugins.coding.lsp' }
}
