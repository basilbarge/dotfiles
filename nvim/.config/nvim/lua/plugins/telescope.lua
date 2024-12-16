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
		require('telescope').setup {
			pickers = {
				find_files = {
					theme = "ivy",
				}
			}
		}

		vim.keymap.set('n', '<leader>e', builtin.diagnostics, {})
		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<leader>en', function()
			builtin.find_files {
				cwd=vim.fn.stdpath("config")
			}
		end)
		vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
		vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}
