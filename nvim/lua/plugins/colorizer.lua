return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require('colorizer').setup ({
			'html',
			'css',
			'javascript',
			'lua',
		})
	end,
}
