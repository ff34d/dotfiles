-- Specs Table
local specs = {}

-- UI hot load
vim.list_extend(specs, {
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	require("plugins.specs.colorscheme"),
	require("plugins.specs.lualine"),
	require("plugins.specs.tree"),
	require("plugins.specs.clue"),
})

-- Concat plugins with dependencies
vim.list_extend(specs, require("plugins.specs.cmp"))
vim.list_extend(specs, require("plugins.specs.telescope"))

-- None load priority specs
vim.list_extend(specs, {
	require("plugins.specs.notify"),
	require("plugins.specs.buffers"),
	require("plugins.specs.lsp"),
	require("plugins.specs.treesitter"),
	require("plugins.specs.conform"),
	require("plugins.specs.colorizer"),
})

-- Load plugins
vim.pack.add(specs, { load = require("lz.n").load })
