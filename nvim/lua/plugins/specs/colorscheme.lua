return {
	src = "https://github.com/folke/tokyonight.nvim",
	data = {
		lazy = false,
		priority = 1000,
		after = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
}
