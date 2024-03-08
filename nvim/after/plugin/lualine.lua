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
	component_background = 'NONE',
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
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

local function insert_left_component(component)
    table.insert(config.sections.lualine_a, component)
end

insert_left_component {
    function()
        return '' -- Custom mode indicator icon
    end,
    color = function()
        -- Auto change color according to Neovim's mode
        local mode_color = {
            n = colors.rose;
            i = colors.foam;
            v = colors.iris;
            V = colors.iris;
            c = colors.love;
            no = colors.rose,
            s = colors.rose,
            S = colors.rose,
            ic = colors.gold,
            R = colors.iris,
            Rv = colors.iris,
            cv = colors.love,
            ce = colors.love,
            r = colors.foam,
            rm = colors.foam,
            ['r?'] = colors.foam,
            ['!'] = colors.love,
            t = colors.love,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1, right = 3 },
}

-- File icon and name component with color
insert_left_component {
    function()
        local icon, iconhl = get_file_icon()
        return '%#' .. iconhl .. '#' .. icon .. ' ' .. vim.fn.expand('%:t') .. '%*'
    end,
    padding = { right = 0 },
}

-- Branch component with fixed color
insert_left_component {
	"branch",
	icon = "󰊢",
	color = { fg = colors.gold }, -- Set branch color to rose
	padding = { left = 2, right = 0 }
}

insert_left_component {
	'diff',
	-- Is it me or the symbol for modified us really weird
	symbols = { added = ' ', modified = ' ', removed = ' ' },
	diff_color = {
		added = { fg = colors.foam },
		modified = { fg = colors.iris },
		removed = { fg = colors.love },
	},
	cond = conditions.hide_in_width,
}

lualine.setup(config)
