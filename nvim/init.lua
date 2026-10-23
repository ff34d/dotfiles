-- Load core files
require("core.options")
require("core.keymaps")

-- Bootstrap
local lzn_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/lz.n"

if not vim.uv.fs_stat(lzn_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/lumen-oss/lz.n",
		lzn_path,
	})
end

-- Load plugins
require("plugins")
