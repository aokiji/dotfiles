return {
  -- Git related plugins
  'tpope/vim-fugitive', 'tpope/vim-rhubarb',

  { -- Adds Git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = {text = '+'},
        change = {text = '~'},
        delete = {text = '_'},
        topdelete = {text = '‾'},
        changedelete = {text = '~'}
      }
    }
  }, -- "gc" to comment visual regions/lines
  {'numToStr/Comment.nvim', opts = {}}, -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth', { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'},
    opts = function()

      -- nvim-cmp setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      cmp.setup {
        snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {'i', 's'})
        },
        sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
      }
    end
  }, -- Asynchronous Lint Engine (linting and fixing)
  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_fixers = {
        ['perl'] = 'perltidy',
        ['cpp'] = 'clang-format',
        ['sql'] = 'pgformatter',
        ['yaml'] = 'prettier',
        ['lua'] = 'lua-format'
      }
      vim.g.ale_sql_pgformatter_options = '-W 10 -w 120'
      vim.g.ale_lua_lua_format_executable = vim.fn.expand('$HOME/.luarocks/bin/lua-format')
      vim.g.ale_lua_lua_format_options = '--column-limit=120 --indent-width=2'
    end
  }, -- LSP Configuration & Plugins
  { -- Useful status updates for LSP
    'williamboman/mason-lspconfig.nvim',
    dependencies = {'williamboman/mason.nvim', opts = {}},
    opts = {
      servers = {
        perlnavigator = {},
        lua_ls = {Lua = {workspace = {checkThirdParty = false}, telemetry = {enable = false}}}
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

          vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
             '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end,
                                             {desc = 'Format current buffer with LSP'})
      end
    },
    config = function(_, opts)
      local mason_lspconfig = require('mason-lspconfig')
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup {ensure_installed = vim.tbl_keys(opts.servers)}
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = opts.on_attach,
            settings = opts.servers[server_name]
          }
        end
      }
    end
  }, {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim', -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      'williamboman/mason-lspconfig.nvim', {'j-hui/fidget.nvim', opts = {}}, -- Additional lua configuration, makes nvim stuff amazing!
      {'folke/neodev.nvim', opts = {}}
    }
  }, { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim', 'perl'},

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = {enable = true},
      indent = {enable = true, disable = {'python'}},
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
          goto_next_start = {[']m'] = '@function.outer', [']]'] = '@class.outer'},
          goto_next_end = {[']M'] = '@function.outer', [']['] = '@class.outer'},
          goto_previous_start = {['[m'] = '@function.outer', ['[['] = '@class.outer'},
          goto_previous_end = {['[M'] = '@function.outer', ['[]'] = '@class.outer'}
        },
        swap = {
          enable = true,
          swap_next = {['<leader>a'] = '@parameter.inner'},
          swap_previous = {['<leader>A'] = '@parameter.inner'}
        }
      }
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
  }, -- symbols outline
  {'simrat39/symbols-outline.nvim', opts = {}}, -- running tests
  {
    'klen/nvim-test',
    opts = {
      termOpts = {direction = 'horizontal', height = 10},
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
      adapters = {perlsp = {type = 'server', host = '127.0.0.1', port = '27011'}},
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
  }, {"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}, opts = {}}
}
