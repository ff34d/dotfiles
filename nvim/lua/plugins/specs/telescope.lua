return {
	-- Telescope dependencies
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{
		src = "https://github.com/nvim-telescope/telescope.nvim",
		data = {
			-- Triggers
			cmd = "Telescope",
			after = function()
				require("telescope").setup()
			end,
		},
	},
}
