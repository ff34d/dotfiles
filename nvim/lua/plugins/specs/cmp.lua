return {
	-- Cmp dependencies
	{
		src = "https://github.com/hrsh7th/cmp-nvim-lsp",
		event = "LspAttach",
	},
	{
		src = "https://github.com/hrsh7th/cmp-buffer",
		event = "InsertEnter",
	},
	{
		src = "https://github.com/hrsh7th/cmp-path",
		event = { "InsertEnter", "CmdlineEnter" },
	},
	{
		src = "https://github.com/hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
	},
	-- Cmp config
	{
		src = "https://github.com/hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		data = {
			after = function()
				local cmp = require("cmp")

				cmp.setup({
					-- Required snippet install
					snippet = {
						expand = function(args)
							vim.snippet.expand(args.body)
						end,
					},

					-- Mappings
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							else
								fallback()
							end
						end, { "i", "s" }),
					}),

					-- Sources
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "path" },
					}, {
						{ name = "buffer" },
					}),
				})
			end,
		},
	},
}
