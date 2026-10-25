return {
	src = "https://github.com/nvim-lualine/lualine.nvim",
	data = {
		lazy = false,
		after = function()
			require("lualine").setup()
		end,
	},
}
