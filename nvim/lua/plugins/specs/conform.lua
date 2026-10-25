return {
	src = "https://github.com/stevearc/conform.nvim.git",
	data = {
		event = "BufReadPre",
		after = function()
			require("conform").setup({
				-- Languages
				formatters_by_ft = {
					lua = { "stylua" },

					-- Web
					-- npm install -g @fsouza/prettierd
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					vue = { "prettierd" },
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
