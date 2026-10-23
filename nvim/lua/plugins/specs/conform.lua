return {
	src = "https://github.com/stevearc/conform.nvim.git",
	data = {
		-- Triggers
		ft = { "lua" },
		after = function()
			require("conform").setup({
				-- Languages
				formatters_by_ft = {
					lua = { "stylua" },
				},
				-- Formatting
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
