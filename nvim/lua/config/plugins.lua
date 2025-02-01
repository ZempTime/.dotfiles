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
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"b0o/schemastore.nvim",
	{ "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",
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
	{ "ThePrimeagen/harpoon",             branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" } },
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
				-- Model aliases configuration
				aliases = {
          sonnet = "claude-3-5-sonnet-latest",
					bedrock_sonnet = "anthropic.claude-3-5-sonnet-20241022-v2:0",
				},
				default = "sonnet",
			})
		end,
	},
	--	{
	--		"christoomey/vim-tmux-navigator",
	--		lazy = false,
	--	},

	-- Automatically check for plugin updates
	checker = { enabled = true },
	-- Colorscheme to use during setup
	install = { colorscheme = { "tokyonight" } },

})
