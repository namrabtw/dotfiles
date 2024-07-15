return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local lualine = require('lualine')
			local webdevicons = require('nvim-web-devicons')

			-- Color table for highlights
			local colors = {
				_nc = "#16141f",
				base = "#191724",
				surface = "#1f1d2e",
				overlay = "#26233a",
				muted = "#6e6a86",
				subtle = "#908caa",
				text = "#e0def4",
				love = "#eb6f92",
				gold = "#f6c177",
				rose = "#ebbcba",
				pine = "#31748f",
				foam = "#9ccfd8",
				iris = "#c4a7e7",
				highlight_low = "#21202e",
				highlight_med = "#403d52",
				highlight_high = "#524f67",
				none = "NONE",
			}

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
				end,
			}

			-- Function to get file icon based on filetype with color
			local function get_file_icon()
				local icon, iconhl = webdevicons.get_icon(vim.fn.expand('%:t'), vim.fn.expand('%:e'), { default = true, color = true })
				return icon or '', iconhl -- fallback to a generic icon if not found
			end

			-- Config
			local config = {
				options = {
					component_separators = '',
					section_separators = '',
					theme = {
						normal = { a = { fg = colors.text, bg = colors.none }},
						inactive = { a = { fg = colors.text, bg = colors.none } },
					},
				},
				sections = {
					lualine_a = {}, -- Remove defaults
					lualine_b = {},
					lualine_c = {}, -- Custom section
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			}

			-- Inserts a component in lualine_a at left section
			local function insert_left_component(component)
				table.insert(config.sections.lualine_a, component)
			end

			-- Inserts a component in lualine_z at right section
			local function insert_right_component(component)
				table.insert(config.sections.lualine_z, component)
			end

			insert_left_component {
				function()
					return ' '
				end,
				color = { fg = colors.none, bg = colors.none },
				padding = { left = 0, right = 0 }
			}

			insert_left_component {
				function()
					return '  ' -- Custom mode indicator icon
				end,
				-- color = function()
				-- 	-- Auto change color according to Neovim's mode
				-- 	local mode_color = {
				-- 		n = colors.surface;
				-- 		i = colors.pine;
				-- 		v = colors.iris;
				-- 		V = colors.iris;
				-- 		c = colors.love;
				-- 		no = colors.rose,
				-- 		s = colors.rose,
				-- 		S = colors.rose,
				-- 		ic = colors.gold,
				-- 		R = colors.iris,
				-- 		Rv = colors.iris,
				-- 		cv = colors.love,
				-- 		ce = colors.love,
				-- 		r = colors.foam,
				-- 		rm = colors.foam,
				-- 		['r?'] = colors.foam,
				-- 		['!'] = colors.love,
				-- 		t = colors.love,
				-- 	}
				-- 	return { fg = colors.text, bg = mode_color[vim.fn.mode()] }
				-- end,
				color = { fg = colors.text, bg = colors.surface },
				padding = { left = 0, right = 0 },
				separator = { right = ' ', left = ' ' },
			}

			-- File icon and name component with color
			insert_left_component {
				function()
					local icon, iconhl = get_file_icon()
					return '%#' .. iconhl .. '#' .. icon .. ' ' .. vim.fn.expand('%:t') .. '%*'
				end,
				padding = { left = 0, right = 0 }
			}

			-- Branch component with fixed color
			insert_left_component {
				"branch",
				icon = "󰊢",
				color = { fg = colors.gold, bg = colors.surface }, -- Set branch color to gold
				separator = { right = '', left = ' ' },
				padding = { left = 0, right = 0 },
			}

			insert_left_component {
				'diff',
				symbols = { added = ' ', modified = ' ', removed = ' ' },
				diff_color = {
					added = { fg = colors.foam },
					modified = { fg = colors.iris },
					removed = { fg = colors.love },
				},
				color = { bg = colors.overlay },
				cond = conditions.hide_in_width,
				separator = { right = ' ', left = '' },
				padding = { left = 1, right = 0 }
			}

			insert_left_component {
				function()
					return ' '
				end,
				color = { fg = colors.none, bg = colors.none },
				padding = { left = 0, right = 0 }
			}

			insert_left_component {
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', hint = '⚑ ', info = '󰌵 ' },
				diagnostics_color = {
					color_error = { fg = colors.love },
					color_warn = { fg = colors.gold },
					color_info = { fg = colors.foam },
				},
				padding = { left = 0, right = 0 }
			}

			insert_right_component {
				'progress',
				cond = conditions.hide_in_width,
				padding = { left = 0, right = 0 }
			}

			insert_right_component {
				function()
					return ' 󱞇 ' -- Custom progress indicator icon
				end,
				color = { fg = colors.text, bg = colors.surface },
				separator = { right = ' ', left = ' ' },
				padding = { left = 0, right = 0 }
			}

			insert_right_component {
				'location',
				cond = conditions.hide_in_width,
				padding = { left = 0, right = 0 }
			}

			insert_right_component {
				function()
					return '  ' -- Custom location indicator icon
				end,
				color = { fg = colors.text, bg = colors.surface },
				separator = { right = ' ', left = ' ' },
				padding = { left = 0, right = 0 }
			}

			insert_right_component {
				function()
					return ' '
				end,
				color = { fg = colors.none, bg = colors.none },
				padding = { left = 0, right = 0 }
			}

			lualine.setup(config)
		end,
	},
}
