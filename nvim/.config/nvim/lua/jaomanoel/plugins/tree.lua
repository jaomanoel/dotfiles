return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 60,
					side = "left",
				},
				renderer = {
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
				},
				filters = {
					dotfiles = true, -- Mostra arquivos ocultos
				},
				sync_root_with_cwd = true, -- Sincroniza a raiz com o diretório atual
				update_cwd = true, -- Atualiza a raiz do nvim-tree com o diretório atual
				update_focused_file = {
					enable = true,
					update_cwd = true, -- Atualiza a raiz com base no arquivo focado
				},
			})
		end,
	},
}
