vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.splitbelow = true
-- vim.opt.exrc = true
-- vim.opt.secure = true
-- vim.opt.backup = false
-- vim.opt.swapfile = false
-- vim.opt.smartindent = true
-- vim.opt.wrap = false
vim.opt.expandtab = true
-- vim.opt.termguicolors = true
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- vim.opt.hlsearch = false
-- vim.opt.signcolumn = "yes"
-- vim.opt.colorcolumn = "+1"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- vim.opt.scrolloff = 8
-- vim.opt.sidescrolloff = 16
-- vim.opt.scroll = 8
-- vim.opt.updatetime = 50
-- vim.opt.cursorline = true
-- vim.opt.cursorlineopt = { "number" }
-- vim.opt.mouse = ""
-- vim.opt.showmode = false
-- vim.opt.undofile = true
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
-- vim.opt.inccommand = 'split'
-- vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- -- Don't pass messages to |ins-completion-menu|.
-- vim.opt.shortmess:append "c"

-- -- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>pv", ":Oil<CR>")

-- Open lsp error messages & make them focusable
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Open diagnostic float'})
vim.diagnostic.config({
  float = { focusable = true }
})


vim.keymap.set('n', '<leader>/', function()
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })

vim.keymap.set('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })


-- Ask LLM about code
vim.keymap.set('n', '<leader>lc', '<cmd>Chat vsplit %<CR>', { noremap = true, desc = "Chat with the current buffer" })
vim.keymap.set('v', '<leader>lc', '<cmd>Chat vsplit<CR>', { noremap = true, desc = "Chat with selected code" })
vim.keymap.set('n', '<leader>ld', '<cmd>Chat vsplit %:h<CR>', { noremap = true, desc = "Chat with the current directory" })

-- Only set <C-a> mappings if not in telescope buffer
local function set_add_keymap()
  local opts = { noremap = true, silent = true }
  -- Check if current buffer is not a telescope prompt
  if vim.bo.filetype ~= "TelescopePrompt" and vim.bo.filetype ~= "oil" then
    vim.keymap.set('n', '<C-a>', ':Add<CR>', vim.tbl_extend('force', opts, { desc = "Add context to LLM" }))
    vim.keymap.set('v', '<C-a>', ':Add<CR>', vim.tbl_extend('force', opts, { desc = "Add selected context to LLM" }))
  end
end

-- Set up an autocmd to run when entering buffers
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    set_add_keymap()
  end,
})

-- Add context to LLM
vim.keymap.set('n', '<leader>ad', '<cmd>Add<CR>', { noremap = true, desc = "Add context to LLM" })
vim.keymap.set('v', '<leader>ad', '<cmd>Add<CR>', { noremap = true, desc = "Add selected context to LLM" })

-- Speech to text
vim.keymap.set('i', '<C-o>', '<cmd>Stt<CR>', { noremap = true, silent = true, desc = "Speech to text" })

vim.keymap.set("n", "<leader>cf", function()
    local relative_path = vim.fn.expand('%:~:.')
    vim.fn.setreg('+', relative_path)
    vim.notify('Copied: ' .. relative_path)
end, { desc = "Copy relative file path to clipboard" })


-- Navigate windows with Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true, desc = "Navigate to left window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true, desc = "Navigate to bottom window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true, desc = "Navigate to top window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true, desc = "Navigate to right window" })

vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 6
vim.opt.foldnestmax = 4


vim.api.nvim_create_user_command('W', 'w', {})
