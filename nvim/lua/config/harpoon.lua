local harpoon = require("harpoon")
harpoon:setup({}) -- Initialize Harpoon

-- Cache Harpoon list for reuse
local harpoon_list = harpoon:list()

-- Key mappings
vim.keymap.set("n", "<leader>a", function()
	harpoon_list:add()
end, { desc = "Add file to Harpoon list" })

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon_list)
end, { desc = "Toggle Harpoon menu" })

vim.keymap.set("n", "<C-h>", function()
	harpoon_list:select(1)
end, { desc = "Go to Harpoon mark 1" })
vim.keymap.set("n", "<C-t>", function()
	harpoon_list:select(2)
end, { desc = "Go to Harpoon mark 2" })
vim.keymap.set("n", "<C-n>", function()
	harpoon_list:select(3)
end, { desc = "Go to Harpoon mark 3" })
vim.keymap.set("n", "<C-s>", function()
	harpoon_list:select(4)
end, { desc = "Go to Harpoon mark 4" })

-- Navigate previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
	harpoon_list:prev()
end, { desc = "Go to previous Harpoon mark" })
vim.keymap.set("n", "<C-S-N>", function()
	harpoon_list:next()
end, { desc = "Go to next Harpoon mark" })

-- Optional: Telescope integration for Harpoon
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers").new({}, {
		prompt_title = "Harpoon",
		finder = require("telescope.finders").new_table({
			results = file_paths,
		}),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end

vim.keymap.set("n", "<leader>th", function()
	toggle_telescope(harpoon_list)
end, { desc = "Toggle Telescope Harpoon marks" })
