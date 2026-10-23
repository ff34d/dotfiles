return {
	src = "https://github.com/neovim/nvim-lspconfig",
	data = {
		-- Triggers
		ft = { "lua" },
		after = function()
			local config = vim.lsp.config

			-- Lsp languages
			local languages = {
				"lua_ls",
			}

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.enable(languages)
		end,
	},
}
