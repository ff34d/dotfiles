return {
	src = "https://github.com/j-hui/fidget.nvim",
	data = {
		event = "DeferredUIEnter",
		after = function()
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
						border = "rounded",
					},
				},
			})
		end,
	},
}
