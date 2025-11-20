return {
	'chomosuke/typst-preview.nvim',
	lazy = false,
	version = "1.*",
	opts = {},
	config = function()
		require "typst-preview".setup()
	end,
}
