return {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	data = {
		event = "BufReadPre",
		after = function()
			local parsers = {
				-- Web
				"typescript",
				"javascript",
				"tsx",
				"vue",
				"html",
				"scss",
				"css",

				-- Configs
				"json",
				"toml",
				"yaml",

				-- Docs
				"markdown",

				-- Script
				"lua",
				"bash",

				-- Other
				"regex",
				"dockerfile",
			}

			require("nvim-treesitter").install(parsers)
		end,
	},
}
