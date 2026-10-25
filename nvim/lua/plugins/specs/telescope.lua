return {
	-- Telescope dependencies
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		data = {
			event = "DeferredUIEnter",
			after = function()
				require("telescope").setup({
					defaults = {
						file_ignore_patterns = {
							"node_modules/.*",
							"%.git/.*",
							"%.DS_Store",
							"dist/.*",
							"build/.*",
						},
					},
					pickers = {
						find_files = {
							theme = "dropdown",
						},
					},
				})
			end,
		},
	},
}
