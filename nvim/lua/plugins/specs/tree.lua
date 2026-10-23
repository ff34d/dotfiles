return {
	-- Nvim tree dependencies
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{
		src = "https://github.com/nvim-tree/nvim-tree.lua",
		lazy = false,
		data = {
			after = function()
				require("nvim-tree").setup({
					-- Configuration
					on_attach = function(bufnr)
						local api = require("nvim-tree.api")

						-- Kyemaps
						local opts = { buffer = bufnr, silent = true, nowait = true }

						vim.keymap.set("n", "l", api.node.open.edit, opts) -- Open edit & Open directory
						vim.keymap.set("n", "a", api.fs.create, opts) -- Create file or directory
						vim.keymap.set("n", "d", api.fs.remove, opts) -- Delete file or directory
						vim.keymap.set("n", "r", api.fs.rename, opts) -- Rename file or directory
					end,
				})
			end,
		},
	},
}
