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

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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
vim.keymap.set('n', '<leader>la', '<cmd>Ask split %<CR>', { noremap = true, desc = "Ask LLM about current buffer" })
vim.keymap.set('v', '<leader>la', '<cmd>Ask split<CR>', { noremap = true, desc = "Ask LLM about selection" })

-- Code with LLM
vim.keymap.set('n', '<leader>lc', '<cmd>Code split %<CR>', { noremap = true, desc = "Start coding with LLM on current buffer" })
vim.keymap.set('v', '<leader>lc', '<cmd>Code split<CR>', { noremap = true, desc = "Start coding with LLM on selection" })
vim.keymap.set('n', '<leader>ld', '<cmd>Code split %:h<CR>', { noremap = true, desc = "Start coding with LLM on files in current directory" })

-- Apply LLM changes
vim.keymap.set('n', '<leader>lp', '<cmd>Apply all<CR>', { noremap = true, desc = "Apply all LLM changes" })

-- Add context to LLM
vim.keymap.set('n', '<leader>ad', '<cmd>Add<CR>', { noremap = true, desc = "Add context to LLM" })
vim.keymap.set('v', '<leader>ad', '<cmd>Add<CR>', { noremap = true, desc = "Add selected context to LLM" })

-- Speech to text
vim.keymap.set('i', '<C-o>', '<cmd>Stt<CR>', { noremap = true, silent = true, desc = "Speech to text" })

-- Fast coding with Yolo mode
vim.keymap.set('n', '<leader>ly', '<cmd>Yolo split %<CR>', { noremap = true, desc = "Fast coding with LLM on current buffer. Automatically applies changes and closes the chat buffer" })
vim.keymap.set('v', '<leader>ly', '<cmd>Yolo split<CR>', { noremap = true, desc = "Fast coding with LLM on selection. Automatically applies changes and closes the chat buffer" })

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
