---@diagnostic disable: undefined-global
local vim = vim

local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colours = {
  bg       = '#161617',
  fg       = '#C9C7CD',
  yellow   = '#E6B99D',
  cyan     = '#EA83A5',
  darkblue = '#ACA1CF',
  green    = '#9DC6AC',
  orange   = '#F5A191',
  violet   = '#ACA1CF',
  magenta  = '#EA83A5',
  blue     = '#90B99F',
  red      = '#F59182',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colours.fg, bg = colours.bg } },
			inactive = { c = { fg = colours.fg, bg = colours.bg } },
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
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

local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colours.blue }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	function()
		return ""
	end,
	color = function()
		local mode_color = {
			n = colours.red,
			i = colours.green,
			v = colours.blue,
			[""] = colours.blue,
			V = colours.blue,
			c = colours.magenta,
			no = colours.red,
			s = colours.orange,
			S = colours.orange,
			[""] = colours.orange,
			ic = colours.yellow,
			R = colours.violet,
			Rv = colours.violet,
			cv = colours.red,
			ce = colours.red,
			r = colours.cyan,
			rm = colours.cyan,
			["r?"] = colours.cyan,
			["!"] = colours.red,
			t = colours.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})

ins_left({
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colours.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colours.fg, gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		error = { fg = colours.red },
		warn = { fg = colours.yellow },
		info = { fg = colours.cyan },
	},
})

ins_left({
	function()
		return "%="
	end,
})

ins_left({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colours.fg, gui = "bold" },
})

ins_right({
	"o:encoding",
	fmt = string.upper,
	cond = conditions.hide_in_width,
	color = { fg = colours.green, gui = "bold" },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = true,
	color = { fg = colours.green, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colours.violet, gui = "bold" },
})

ins_right({
	"diff",
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colours.green },
		modified = { fg = colours.orange },
		removed = { fg = colours.red },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colours.blue },
	padding = { left = 1 },
})

lualine.setup(config)

require("bufferline").setup()

-- vim: ft=lua ts=2 sts=2 sw=2 et ai
