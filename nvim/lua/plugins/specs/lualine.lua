return {
	-- Lualine dependencies
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{
		src = "https://github.com/nvim-lualine/lualine.nvim",
		lazy = false,
		data = {
			after = function()
				require("lualine").setup()
			end,
		},
	},
}
