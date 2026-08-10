return {
	{
		dir = "~/Projects/typst-compile.nvim",
		config = function()
			require "typst-compile".setup()

			local comp = require "typst-compile".compile

			vim.keymap.set("n", "<leader>tc", comp)
		end
	}
}
--return {
--	{
--		'basilbarge/typst-compile.nvim',
--		dependencies = {'nvim-treesitter/nvim-treesitter' },
--		config = function()
--			require "typst-compile".setup()
--
--			local comp = require "typst-compile".compile
--
--			vim.keymap.set("n", "<leader>tc", comp)
--		end
--	},
--}
