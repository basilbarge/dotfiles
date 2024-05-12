return {
	'tpope/vim-fugitive',
	config = function()
		vim.keymap.set('n', '<leader>g', '<cmd>G<CR>')
		vim.keymap.set('n', '<leader>gP', '<cmd>G push<CR>')
	end
}
