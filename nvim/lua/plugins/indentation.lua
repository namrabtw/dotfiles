return {
	"lukas-reineke/indent-blankline.nvim",
	name = "ibl",
	priority = 1000,
	config = function()
		require('ibl').setup({
			indent = {
				char = "▏",
			},
			scope = {
				char = "▏",
				show_start = false,
				show_end = false
			}
		})
	end,
}
