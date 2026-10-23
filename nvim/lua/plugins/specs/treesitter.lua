return {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	lazy = false,
	data = {
		after = function()
			require("nvim-treesitter").install({ "lua" })
		end,
	},
}
