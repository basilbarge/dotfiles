return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')

		local actions = require("telescope.actions")
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
				},
			},
		}

		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
		vim.keymap.set('n', '<leader>bf', builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set('n', '<leader>hf', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}
