-- ──────────────────────────────────────────────────────────────────────────────
-- LSP keymaps & highlights on attach
-- ──────────────────────────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client.name == 'copilot' then return end

    local builtin = require 'telescope.builtin'
    local map = function(keys, fn)
      vim.keymap.set('n', keys, fn, { buffer = event.buf })
    end

    map('gd', builtin.lsp_definitions)
    map('gr', builtin.lsp_references)
    map('gi', builtin.lsp_implementations)
    map('gt', builtin.lsp_type_definitions)
    map('[e', function() vim.diagnostic.jump({ count = -1 }) end)
    map(']e', function() vim.diagnostic.jump({ count = 1 })  end)
    map('K',  vim.lsp.buf.hover)
    map('gs', vim.lsp.buf.signature_help)
    map('<leader>o', builtin.lsp_document_symbols)
    map('<leader>e', vim.diagnostic.open_float)
    map('<leader>rn', vim.lsp.buf.rename)
    map('<leader>f', function()
      vim.lsp.buf.format { timeout_ms = 4000, bufnr = event.buf }
    end)

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold','CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved','CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    vim.diagnostic.config {
      virtual_text  = true,
      severity_sort = true,
    }
  end,
})

-- ──────────────────────────────────────────────────────────────────────────────
-- Your server-specific settings
-- ──────────────────────────────────────────────────────────────────────────────
local servers = {
  jsonls = {
    settings = {
      json = {
        schemas  = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  cssls     = {},
  ruby_lsp  = {},
  bashls    = {},
  dockerls  = {},
  -- gopls     = {
  --   settings = {
  --     gopls = {
  --       experimentalPostfixCompletions = true,
  --       completeUnimported             = true,
  --       usePlaceholders                = true,
  --       analyses = { unusedparams = true, shadow = true },
  --       staticcheck                    = true,
  --     },
  --   },
  --   init_options = { usePlaceholders = true },
  -- },
  -- basedpyright = {
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoImportCompletions   = true,
  --         autoSearchPaths         = true,
  --         diagnosticMode          = "openFilesOnly",
  --         useLibraryCodeForTypes  = true,
  --         typeCheckingMode        = "basic",
  --       },
  --     },
  --   },
  -- },
  html      = {},
  vimls     = {},
  sqlls     = {},
  lua_ls    = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
        },
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  ts_ls        = {},
  tailwindcss  = {},
  eslint       = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings  = {
      -- /* your eslint settings */
    },
  },
}

-- ──────────────────────────────────────────────────────────────────────────────
-- Mason & capabilities
-- ──────────────────────────────────────────────────────────────────────────────
require("mason").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
  "force",
  capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- ──────────────────────────────────────────────────────────────────────────────
-- Register each server with the new API
-- ──────────────────────────────────────────────────────────────────────────────
for name, opts in pairs(servers) do
  opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
  vim.lsp.config(name, opts)
end

-- ──────────────────────────────────────────────────────────────────────────────
-- Ensure install & automatic enable
-- ──────────────────────────────────────────────────────────────────────────────
require("mason-lspconfig").setup {
  ensure_installed  = vim.tbl_keys(servers),
  automatic_enable  = true,  -- calls vim.lsp.enable() for each installed server
}

