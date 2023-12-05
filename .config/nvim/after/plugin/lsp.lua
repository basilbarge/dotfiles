local lsp = require('lsp-zero').preset({"recommended"})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['C-p'] = cmp.mapping.select_prev_item(cmp_select),
	['C-n'] = cmp.mapping.select_next_item(cmp_select),
	['C-y'] = cmp.mapping.confirm({select = true}),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({})
end)

require('mason').setup({});
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup,
	}
});
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
