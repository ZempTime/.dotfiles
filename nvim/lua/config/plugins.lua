-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "b0o/schemastore.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    config = function()
      -- Enable treesitter highlighting for all filetypes except ruby (slow)
      -- To install parsers: :TSInstall <parser> or require("nvim-treesitter").install({ "lua", "ruby", ... })
      local disabled_langs = { ruby = true }
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if not disabled_langs[ft] then
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
            if not ok or not stats or stats.size < 100 * 1024 then
              pcall(vim.treesitter.start, args.buf)
            end
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
            ["@block.outer"] = "V",
          },
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      local move = require("nvim-treesitter-textobjects.move")

      -- Select keymaps
      vim.keymap.set({ "x", "o" }, "af", function() select("@function.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "if", function() select("@function.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ac", function() select("@class.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ic", function() select("@class.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ab", function() select("@block.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ib", function() select("@block.inner", "textobjects") end)

      -- Move keymaps
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Grep string" })
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  "pangloss/vim-javascript",
  "peitalin/vim-jsx-typescript",
  "leafgarland/typescript-vim",
  "moll/vim-node",
  "tpope/vim-rails",
  "tpope/vim-bundler",
  "editorconfig/editorconfig-vim",
  { 'dmmulroy/ts-error-translator.nvim' },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle", -- Lazy-load when the command is used
    config = function()
      -- Optional: Configure UndoTree behavior
      vim.g.undotree_SetFocusWhenToggle = 1 -- Automatically focus the undotree window when toggled
    end,
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" }, -- Key mapping for toggling UndoTree
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "git@github.com:aha-app/llm-sidekick.nvim.git",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'default-anton/llm-sidekick.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('llm-sidekick').setup({
        aliases = {
          pro = "vertex_ai/gemini-2.5-pro",
          opus = "vertex_ai/claude-opus-4",
          sonnet = "vertex_ai/claude-sonnet-4",
        },
        {
          file_operations = false,              -- Automatically accept file operations
          terminal_commands = false,            -- Automatically accept terminal commands
          auto_commit_changes = false,          -- Enable auto-commit
        },
        auto_commit_model = "gemini-2.0-flash", -- Use a specific model for commit messagesdefault = "sonnet",
        default = 'sonnet',
        safe_terminal_commands = {
          "bin/bundle", "bundle", "bin/rspec", "rspec", "bin/rails", "rails", "bin/rake", "rake",
          "git commit", "mkdir", "touch",
        },
        guidelines = [[
Feel free to use any terminal tools - I have `fd`, `rg`, `gh`, `jq`, `aws` installed and ready to use.]],
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      layout = {
        default_direction = "left",
      },
      link_folds_to_tree = true,
      link_tree_to_folds = true,
      manage_folds = true,
    },
    keys = {
      { "<leader>la", "<cmd>AerialToggle<cr>", desc = "Toggle Aerial" },
    },
  },
}, {
  -- Automatically check for plugin updates
  checker = { enabled = true },
  -- Colorscheme to use during setup
  install = { colorscheme = { "tokyonight" } },
})
