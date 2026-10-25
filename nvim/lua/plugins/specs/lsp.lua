return {
	src = "https://github.com/neovim/nvim-lspconfig",
	data = {
		event = "FileType",
		after = function()
			local config = vim.lsp.config

			-- Install Capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			config("*", {
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.bo[bufnr].omnifunc = ""
				end,
			})

			-- Base path to node modules
			local global_node_modules = vim.fn.trim(vim.fn.system("mise where node")) .. "/lib/node_modules"

			-- Lsp languages
			local languages = {
				"cssls", -- npm i -g vscode-langservers-extracted
				"html", -- npm i -g vscode-langservers-extracted
				"eslint", -- npm i -g vscode-langservers-extracted
				"jsonls", -- npm i -g vscode-langservers-extracted
				"stylelint_lsp", -- npm install -g @stylelint/language-server

				"ts_ls", -- npm install -g typescript typescript-language-server

				"vtsls", -- npm install -g @vtsls/language-server
				"vue_ls", -- npm install -g @vue/language-server

				"lua_ls", -- brew install lua-language-server
			}

			-- Lua_ls setup
			config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = { vim.env.VIMRUNTIME } },
					},
				},
			})

			-- Vtsls setup
			config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = global_node_modules .. "/@vue/language-server",
									languages = { "vue" },
									configNamespace = "typescript",
								},
							},
						},
					},
				},
				filetypes = { "vue" },
			})

			-- Eslint setup
			config("eslint", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
					"html",
				},
				root_markers = {
					"eslint.config.js",
					"eslint.config.mjs",
					"eslint.config.cjs",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				},
				settings = {
					experimental = {
						useFlatConfig = true,
					},
				},
			})

			vim.lsp.enable(languages)
		end,
	},
}
