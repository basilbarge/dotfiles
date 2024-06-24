return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set('n', '<leader>g', '<cmd>G<CR>')
		vim.keymap.set('n', '<leader>gp', '<cmd>G push<CR>')
	end
}
