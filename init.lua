-- Set keymap leaderin
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable modelines
vim.cmd [[set modeline]]

-- Enable nerd font glyphs and icons
vim.g.have_nerd_font = true

-- [[ Setting options ]]

-- Enable filetype plugins and indenting
vim.cmd [[filetype plugin indent on]]

-- Enable syntax highlighting
vim.cmd [[syntax enable]]

-- Set guicursor
vim.cmd [[set guicursor=a:blinkon1]]
vim.cmd [[set guifont=JetBrainsMono_Nerd_Font_Mono:h16:cMAC]]

-- Set shell
vim.opt.shell = '/bin/zsh'

-- Swap files
vim.opt.swapfile = false

-- Buffers
vim.opt.hidden = true

-- Encoding
vim.opt.fileencoding = 'utf-8'

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = 'en_gb'

-- Set relative line numbers on
vim.opt.number = true
vim.opt.relativenumber = true

-- Colour column lines
vim.opt.colorcolumn = '80,100,120'
vim.cmd.hi 'Comment gui=none'

-- Set forced line lengths and wrapping rules
vim.opt.textwidth = 120 -- absolute maximum
vim.opt.formatoptions = 'tcro/n1]jplj' -- :help fo-table

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, it's in the status line
vim.opt.showmode = true

-- Enable break indent
vim.opt.breakindent = true

-- Configure tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.cmd [[set expandtab]]

-- Save undo history
vim.opt.undofile = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 150

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Diagnostics
vim.diagnostic.config {
  underline = true,
  signs = true,
  virtual_text = true,
  float = {
    show_header = true,
    source = 'if_many',
    border = 'rounded',
  },
  update_in_insert = true,
}

-- Context settings
vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp = 'Grey' })
vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { underline = true, sp = 'Grey' })

-- [[ Basic Keymaps ]]

vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })
vim.keymap.set('i', '<Down>', 'gj', { silent = true })
vim.keymap.set('i', '<Up>', 'gk', { silent = true })

-- Basic capitalisation errors
vim.keymap.set('c', 'W', 'w')
vim.keymap.set('c', 'Xa', 'xa')

-- Yank into and paste from the system clipboard
vim.keymap.set('n', '<leader>cy', '"+y')
vim.keymap.set('v', '<leader>cy', '"+y')
vim.keymap.set('n', '<leader>cp', '"+p')
vim.keymap.set('n', '<leader>cP', '"+P')
vim.keymap.set('v', '<leader>cp', '"+p')
vim.keymap.set('v', '<leader>cP', '"+P')

-- Resize current window
vim.keymap.set('n', '+', '<CMD>vertical resize +5<CR>')
vim.keymap.set('n', '_', '<CMD>vertical resize -5<CR>')
vim.keymap.set('n', '=', '<CMD>horizontal resize +5<CR>')
vim.keymap.set('n', '-', '<CMD>horizontal resize -5<CR>')

-- Move buffers
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')
vim.keymap.set('n', '<C-n>', ':bnext<CR>')
vim.keymap.set('n', '<leader>bp', ':bprev<CR>')
vim.keymap.set('n', '<C-p>', ':bprev<CR>')

-- Close the current window and buffer
vim.keymap.set('n', '<leader>cx', ':close<CR>')
vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- File explorer
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list', silent = true })
vim.keymap.set('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', { desc = 'Open next [d]iagnostic floating window', silent = true })
vim.keymap.set('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', { desc = 'Open prev [d]iagnostic floating window', silent = true })

-- Context keymaps
vim.keymap.set('n', '[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })
vim.keymap.set('n', '<leader>ut', ':UndotreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>ur', ':UndotreeFocus<CR>', { silent = true })

-- Fugative / Git keymaps
vim.keymap.set('n', '<leader>dw', ':diff get 2<CR>', { desc = 'Select original git changes', silent = true })
vim.keymap.set('n', '<leader>lp', ':diff get 3<CR>', { desc = 'Select new git changes', silent = true })
vim.keymap.set('n', '<leader>gt', ':Git<CR>', { silent = true })

-- Exit terminal mode in the builtin terminal easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move around highlighted blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', '>', '>gv', { desc = 'Move selection right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Move selection left' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_set_keymap('n', '<leader>bt', ':ShowClock<CR>', { silent = true })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace',
  group = vim.api.nvim_create_augroup('whitespace-rm', { clear = true }),
  command = [[ %s/\s\+$//e ]],
})

-- [[ Install lazy plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require('lazy').setup({
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  { 'mbbill/undotree' },

  { 'tpope/vim-fugitive' },

  { -- Adds git related signs to the gutter
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '±' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { 'folke/zen-mode.nvim' },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  { 'https://github.com/ap/vim-buftabline' },

  { -- Discord notification while in neovim
    'andweeb/presence.nvim',
    event = 'VeryLazy',
    opts = {
      auto_update = true,
      neovim_image_text = "The Lord's Editor",
      enable_line_number = true,
    },
  },

  { 'mfussenegger/nvim-dap' },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-treesitter/nvim-treesitter-context' },
    },
    config = function()
      -- [[ Configure Telescope ]]
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<C-">'] = 'to_fuzzy_refine' },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '`/', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sc', builtin.resume, { desc = '[S]earch [C]ontinue' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<C-\\>', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 0,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files { desc = '[S]earch [F]iles', cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch Relative [F]iles' })
    end,
  },

  { 'ziglang/zig.vim' },

  -- LSP Plugins
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  { -- optional cmp completion source for require statements and module annotations
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    dependencies = {
      'mikavilpas/blink-ripgrep.nvim',
      'rafamadriz/friendly-snippets',
    },
    version = 'v0.7.6',
    build = 'cargo build --release',
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      sources = {
        -- add lazydev to your completion providers
        completion = {
          enabled_providers = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            'ripgrep',
            'lazydev',
          },
          menu = {
            draw = {
              treesittter = true,
              -- columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

              columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
              components = {
                item_idx = {
                  text = function(ctx)
                    return tostring(ctx.idx)
                  end,
                  highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
                },
              },
            },
          },
        },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lsp = { fallback_for = { 'lazydev' } },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = '1M',
              additional_rg_options = {},
            },
          },
        },
      },
      fuzzy = {
        prebuilt_binaries = {
          force_version = 'v0.7.6',
        },
      },
    },
  },
  {
    'tact-lang/tact.vim',
    init = function()
      vim.g.tact_style_guide = 1
      vim.g.tact_prefer_completefunc = 1
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        go = { 'golangcilint' },
        -- c = { 'clangtidy' },
        -- cpp = { 'clangtidy' },
        lua = { 'luacheck' },
        make = { 'checkmake' },
        yaml = { 'yamllint' },
        zsh = { 'zsh' },
        zig = { 'zig' },
        solidity = { 'solhint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', {
        clear = true,
      })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'nvim-java/nvim-java',
    init = function()
      require('java').setup()
    end,
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints from the LSP (if supported)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
                bufnr = event.buf,
              })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local lspconfig = require 'lspconfig'
      local util = require 'lspconfig.util'

      local servers = {
        clangd = {
          capabilities = capabilities,
          filetypes = { 'c' },
          root_dir = lspconfig.util.root_pattern '.clang-format',
        },
        gopls = {
          capabilities = capabilities,
          cmd = { 'gopls' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_dir = util.root_pattern('.git', 'go.mod', 'go.work'),
          setting = {
            gopls = {
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              experimentalPostfixCompletions = true,
              gofumpt = true,
              staticcheck = true,
              usePlaceholders = true,
            },
          },
        },
        rust_analyzer = {
          capabilities = capabilities,
          filetypes = { 'rust' },
          root_dir = lspconfig.util.root_pattern 'Cargo.toml',
        },
        zls = {
          capabilities = capabilities,
          filetypes = { 'zig' },
          root_dir = util.root_pattern('build.zig', '.git'),
          docs = {
            description = [[ ]],
            default_config = {
              root_dir = [[root_pattern("build.zig", ".git")]],
            },
          },
        },
        lua_ls = {
          -- cmd = {...},
          filetypes = { 'lua' },
          capabilities = capabilities,
          settings = {
            lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = {
                  'vim',
                  'vim.g',
                  'vim.opt',
                  'vim.cmd',
                  'vim.keymap',
                },
              },
            },
          },
        },
        solidity = {
          capabilities = capabilities,
          cmd = { 'vscode-solidity-server', '--stdio' },
          -- cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
          filetypes = { 'solidity' },
          require('lspconfig.util').root_pattern 'foundry.toml',
          single_file_support = true,
        },
        jdtls = {},
      }

      require('mason').setup()

      local ensure_installed = {
        'stylua',
        'lua-language-server',
        'luacheck',
        'gopls',
        'golangci-lint',
        'golines',
        'goimports-reviser',
        'rust_analyzer',
        'zls',
        'clangd',
        'clang-format',
        'codelldb',
        'solhint',
        'vscode-solidity-server',
        'solidity-ls',
        -- 'nomicfoundation-solidity-language-server',
        'jdtls',
      }
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        run_in_floaterm = true,
      }

      vim.keymap.set('n', '<leader>ie', ':GoIfErr<CR>', { desc = 'Automatically generate an [I]f [E]rr error check.' })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style.
        local disable_filetypes = { ts = true, js = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        c = { 'clang-format' },
        go = { 'gofumpt', 'goimports-reviser', 'golines' },
      },
    },
  },

  -- { -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     -- Snippet Engine & its associated nvim-cmp source
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = (function()
  --         return 'make install_jsregexp'
  --       end)(),
  --       dependencies = {
  --         -- {
  --         --   'rafamadriz/friendly-snippets',
  --         --   config = function()
  --         --     require('luasnip.loaders.from_vscode').lazy_load()
  --         --   end,
  --         -- },
  --       },
  --     },
  --     'saadparwaiz1/cmp_luasnip',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --   },
  --   config = function()
  --     local cmp = require 'cmp'
  --     local luasnip = require 'luasnip'
  --     luasnip.config.setup {}
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       -- completion = { completeopt = 'menu,menuone,noinsert,preview,noselect' },
  --
  --       mapping = cmp.mapping.preset.insert {
  --         -- Completion selection
  --         ['<CR>'] = cmp.mapping.confirm { select = true },
  --         ['<C-n'] = cmp.mapping.select_next_item(),
  --         ['<C-p>'] = cmp.mapping.select_prev_item(),
  --
  --         -- Scroll the documentation window [b]ack / [f]orward
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --
  --         -- Accept ([y]es) the completion.
  --         --  This will auto-import if your LSP supports it.
  --         --  This will expand snippets if the LSP sent a snippet.
  --         ['<C-y>'] = cmp.mapping.confirm { select = true },
  --
  --         -- <c-l> will move you to the right of each of the expansion locations.
  --         -- <c-h> is similar, except moving you backwards.
  --         --
  --         --  So if you have a snippet that's like:
  --         --  function $name($args)
  --         --    $body
  --         --  end
  --         ['<C-l>'] = cmp.mapping(function()
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-h>'] = cmp.mapping(function()
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           end
  --         end, { 'i', 's' }),
  --       },
  --       sources = {
  --         {
  --           name = 'lazydev',
  --           -- skip loading LuaLS completions as lazydev recommends it
  --           group_index = 0,
  --         },
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --         { name = 'buffer' },
  --         { name = 'path' },
  --       },
  --     }
  --   end,
  -- },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
  },

  -- Diagnostics
  {
    'stevearc/dressing.nvim',
    opts = {},
    init = function()
      require('dressing').setup {
        input = {
          win_options = {
            winhighlight = 'NormalFloat:DiagnosticError',
          },
        },
        select = {
          get_config = function()
            return {
              backend = 'fzf',
              nui = {
                relative = 'cursor',
                max_width = 40,
              },
            }
          end,
        },
      }
    end,
  },

  -- Screencaps
  {
    'mistricky/codesnap.nvim',
    build = 'make build_generator',
    opts = {
      title = 'code snippet',
      save_path = '~/Captures/CodeSnaps/',
      has_line_number = true,
      watermark = '',
      code_font_family = 'JetBrainsMono Nerd Font',
      bg_theme = 'summer',
      bg_padding = 16,
    },
    config = function(_, opts)
      require('codesnap').setup(opts)
    end,
  },

  -- Colorscheme
  {
    'tiagovla/tokyodark.nvim',
    priority = 1000, -- load this before all the other start plugins.
    config = function()
      -- vim.cmd [[colorscheme tokyodark]]
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000, -- load this before all the other start plugins.
    config = function()
      vim.cmd [[colorscheme rose-pine]]
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  { 'ovikrai/mojo-syntax' },

  {
    'vague2k/vague.nvim',
    priority = 1000, -- load this before all the other start plugins.
    config = function()
      require('vague').setup {
        transparent = false, -- don't set background
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = 'none',
          number = 'none',
          float = 'none',
          error = 'none',
          comments = 'italic',
          conditionals = 'none',
          functions = 'none',
          headings = 'bold',
          operators = 'none',
          strings = 'italic',
          variables = 'none',

          -- keywords
          keywords = 'none',
          keyword_return = 'none',
          keywords_loop = 'none',
          keywords_label = 'none',
          keywords_exception = 'none',

          -- builtin
          builtin_constants = 'none',
          builtin_functions = 'none',
          builtin_types = 'none',
          builtin_variables = 'none',
        },
        -- Override colors
        colors = {
          bg = '#18191a',
          fg = '#cdcdcd',
          floatBorder = '#878787',
          line = '#282830',
          comment = '#646477',
          builtin = '#bad1ce',
          func = '#be8c8c',
          string = '#deb896',
          number = '#d2a374',
          property = '#c7c7d4',
          constant = '#b4b4ce',
          parameter = '#b9a3ba',
          visual = '#363738',
          error = '#d2788c',
          warning = '#e6be8c',
          hint = '#8ca0dc',
          operator = '#96a3b2',
          keyword = '#7894ab',
          type = '#a1b3b9',
          search = '#465362',
          plus = '#8faf77',
          delta = '#e6be8c',
        },
      }
    end,
  },

  -- Better Around/Inside textobjects
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  --
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- Examples:
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 750 }

      require('mini.surround').setup()

      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- To configure sections in the statusline, override their default behaviour.
      -- statusline.section_location = function()
      --   return 'L:%3l § C:%3v'
      -- end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'dockerfile',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',
        'gpg',
        'zig',
        'rust',
        'diff',
        'lua',
        'luadoc',
        'make',
        'markdown_inline',
        'proto',
        'python',
        'query',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {},
      },
      indent = { enable = true, disable = {} },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]]

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    'wallpants/github-preview.nvim',
    cmd = { 'GithubPreviewToggle' },
    keys = { '<leader>mpt' },
    opts = {},
    config = function(_, opts)
      local gpreview = require 'github-preview'
      gpreview.setup(opts)

      local fns = gpreview.fns
      vim.keymap.set('n', '<leader>mpt', fns.toggle)
      vim.keymap.set('n', '<leader>mps', fns.single_file_toggle)
      vim.keymap.set('n', '<leader>mpd', fns.details_tags_toggle)
    end,
  },

  ---@module "lazy"
  ---@type LazySpec
  {
    'TymekDev/spotlight.nvim',
    ---@module "spotlight"
    ---@type spotlight.ConfigPartial
    opts = {},
  },

  -- Local plugins
  {
    dir = '~/.config/nvim/plugins/verses.nvim',
    cmd = { 'VersesChapters' },
  },

  {
    dir = '~/.config/nvim/plugins/clock.nvim',
    cmd = { 'ShowClock' },
  },

  {
    dir = '~/.config/nvim/plugins/conv.nvim',
    cmd = { 'B2H', 'B2D', 'H2B', 'H2D' },
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
