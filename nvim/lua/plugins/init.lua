local lz = require("lz.n")

-- Base non dependencies plugins
local specs = {
	require("plugins.specs.lsp"),
	require("plugins.specs.conform"),
	require("plugins.specs.treesitter"),
}

-- Concat plugins with dependencies
vim.list_extend(specs, require("plugins.specs.tree"))
vim.list_extend(specs, require("plugins.specs.lualine"))
vim.list_extend(specs, require("plugins.specs.telescope"))
vim.list_extend(specs, require("plugins.specs.cmp"))

-- Load plugins
vim.pack.add(specs, { load = require("lz.n").load })
