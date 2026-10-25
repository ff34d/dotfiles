return {
	src = "https://github.com/romgrk/barbar.nvim",
	data = {
		event = "DeferredUIEnter",
		after = function()
			require("barbar").setup({
				animation = false,
				icons = {
					gitsigns = {
						added = { enabled = true, icon = "+" },
						changed = { enabled = true, icon = "~" },
						deleted = { enabled = true, icon = "-" },
					},
				},
			})
		end,
	},
}
