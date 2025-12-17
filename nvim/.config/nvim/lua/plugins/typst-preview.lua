return {
	'chomosuke/typst-preview.nvim',
	lazy = false,
	version = "1.*",
	opts = {},
	config = function()
		require "typst-preview".setup()

		vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
			pattern = {'*.typ'},
			callback = function()
				vim.keymap.set("n", "<leader>tp", ":TypstPreview<CR>")
				vim.keymap.set("n", "<leader>sc", ":TypstPreviewSyncCursor<CR>")
			end
		})
	end,
}
