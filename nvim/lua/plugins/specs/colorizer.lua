return {
	src = "https://github.com/catgoose/nvim-colorizer.lua",
	data = {
		event = "BufReadPre",
		after = function()
			require("colorizer").setup()
		end,
	},
}
