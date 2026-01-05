return {
	'nvim-telescope/telescope.nvim',
	tag = 'v0.2.1',
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	config = function()

		require('telescope').setup {
			pickers = {
				find_files = {
					theme = "ivy",
				},
				help_tags = {
					theme = "ivy"
				}
			}
		}


		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>e', builtin.diagnostics)
		vim.keymap.set('n', '<leader>pf', builtin.find_files)
		vim.keymap.set('n', '<leader>en', function()
			builtin.find_files {
				cwd = vim.fn.stdpath("config")
			}
		end)
		vim.keymap.set('n', '<leader>gf', builtin.git_files)
		vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find)
		vim.keymap.set('n', '<leader>fh', builtin.help_tags)
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}
