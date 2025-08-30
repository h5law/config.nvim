---@diagnostic disable: undefined-global
local vim = vim

---@diagnostic disable: undefined-global
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[ filetype plugin indent on ]])
vim.cmd([[ syntax on ]])

-- Enable modelines
vim.opt.modeline = true

-- [[ Setting options ]]

-- Set shell
vim.opt.shell = "/usr/bin/fish"

-- Swap files
vim.opt.swapfile = true
vim.opt.updatetime = 150
vim.opt.updatecount = 50

-- Buffers
vim.opt.hidden = true

-- Encoding
vim.opt.fileencoding = "utf-8"

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_gb"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Colour column
vim.opt.colorcolumn = "80,100,120"

-- Line length and wrapping
vim.opt.textwidth = 100
vim.opt.formatoptions = "tcro/n1jpl" -- Removed invalid ']' character

-- Enable mouse
vim.opt.mouse = "a"

-- Hide mode (shown in statusline)
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Undo history
vim.opt.undofile = true

-- Signcolumn
vim.opt.signcolumn = "yes"

-- Timeout for key sequences
vim.opt.timeoutlen = 300

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live substitutions
vim.opt.inccommand = "split"

-- Cursor line
vim.opt.cursorline = true

-- Scroll offset
vim.opt.scrolloff = 5

-- Diagnostics
vim.diagnostic.config({
	underline = true,
	signs = true,
	virtual_text = true,
	float = {
		show_header = true,
		source = "if_many",
		border = "rounded",
	},
	update_in_insert = true,
})

-- Treesitter context highlights
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { underline = true, sp = "Grey" })

-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Quick save file", silent = true })
vim.keymap.set("n", "<leader>wa", ":wa<CR>", { desc = "Quick save all files", silent = true })
vim.keymap.set("n", "<leader>wq", ":xa<CR>", { desc = "Quick save and quit all files", silent = true })

vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

-- Clipboard keymaps
vim.keymap.set({ "n", "v" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>cP", '"+P', { desc = "Paste before from system clipboard" })

-- Resize windows
vim.keymap.set("n", "+", ":vertical resize +5<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "_", ":vertical resize -5<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "=", ":horizontal resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "-", ":horizontal resize -5<CR>", { desc = "Decrease window height" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-p>", ":bprev<CR>", { desc = "Previous buffer" })

-- Close window/buffer
vim.keymap.set("n", "<leader>cx", ":close<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>bx", ":bdelete!<CR>", { desc = "Delete buffer" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list", silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", silent = true })

-- Treesitter context
vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-- Undo tree
vim.keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle undo tree", silent = true })
vim.keymap.set("n", "<leader>ur", ":UndotreeFocus<CR>", { desc = "Focus undo tree", silent = true })

-- Noise dismiss
vim.keymap.set("n", "<ESC><ESC>", function()
	vim.cmd([[ nohlsearch ]])
end, { desc = "Dismiss noice notifications", silent = true })

-- Move selected blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent selection" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- File navigation
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil buffer", silent = true })
vim.keymap.set("n", "<leader>-", ":Oil<CR>", { desc = "Open Oil buffer", silent = true })
vim.keymap.set("n", "<leader>=", ":Oil --float<CR>", { desc = "Open floating Oil buffer", silent = true })

-- Toggle terminal
vim.keymap.set("n", "<leader>;", ":ToggleTerm<CR>", { desc = "Toggle floating terminal", silent = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Remove trailing whitespace",
	group = vim.api.nvim_create_augroup("whitespace-rm", { clear = true }),
	command = [[%s/\s\+$//e]],
})

-- Plugin Manager
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("j-hui/fidget.nvim")
Plug("MunifTanjim/nui.nvim")
Plug("echasnovski/mini.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("ibhagwan/fzf-lua")
Plug("zackhsi/fzf-tags")
Plug("neovim/nvim-lspconfig")
Plug("p00f/clangd_extensions.nvim")
-- Plug("ranjithshegde/ccls.nvim")
Plug("mfussenegger/nvim-lint")
Plug("stevearc/conform.nvim")
Plug("stevearc/dressing.nvim")
Plug("folke/trouble.nvim")
Plug("nvim-treesitter/nvim-treesitter")
Plug("ziglang/zig.vim")
Plug("mbbill/undotree")
Plug("lewis6991/gitsigns.nvim")
Plug("stevearc/oil.nvim")
Plug("refractalize/oil-git-status.nvim")
Plug("nvim-lualine/lualine.nvim")
Plug("andweeb/presence.nvim")
Plug("akinsho/bufferline.nvim")
Plug("lukas-reineke/cmp-rg")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")
Plug("amarakon/nvim-cmp-buffer-lines")
Plug("hrsh7th/cmp-nvim-lsp-document-symbol")
Plug("hrsh7th/cmp-nvim-lsp-signature-help")
Plug("onsails/lspkind.nvim")
Plug("ray-x/go.nvim")
Plug("ray-x/guihua.lua")
Plug("akinsho/toggleterm.nvim")
Plug("nvzone/showkeys")
Plug("folke/todo-comments.nvim")
Plug("MeanderingProgrammer/render-markdown.nvim")
Plug("mellow-theme/mellow.nvim")

vim.call("plug#end")

-- Plugin Configurations

require("mini.icons").setup({})
require("mini.ai").setup({ n_lines = 750 })
require("mini.surround").setup({})

require("nvim-treesitter").setup({
	auto_install = true,
})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "±" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

require("toggleterm").setup({
	direction = "float",
	open_mapping = [[<c-;>]],
})

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sm", fzf.manpages, { desc = "[S]earch system [M]anpages" })
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = "[S]earch Recent Files" })
vim.keymap.set("n", "<leader>sb", fzf.lgrep_curbuf, { desc = "[S]earch in Current [B]buffer" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep_native, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sc", fzf.resume, { desc = "[S]earch [C]ontinue" })

require("oil").setup({
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	win_options = {
		relativenumber = true,
		number = true,
		signcolumn = "yes:4",
		cursorline = true,
		cursorcolumn = true,
	},
	delete_to_trash = true,
	watch_for_changes = true,
	float = {
		padding = 2,
		max_width = 0.75,
		max_height = 0.4,
		preview_split = "right",
	},
})

require("presence").setup({
	auto_update = true,
	neovim_image_text = "The Lord's Editor",
	enable_line_number = true,
})

require("lint").linters_by_ft = {
	c = { "clangtidy" },
	cpp = { "clangtidy" },
	go = { "golangcilint", "golines", "gofumpt" },
	lua = { "luacheck" },
	make = { "checkmake" },
	zig = { "zls" },
	sh = { "shellcheck" },
}

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    c = { "clangtidy", lsp_format = "fallback" },
    cpp = { "clangtidy", lsp_format = "fallback" },
    zig = { "zls", lsp_format = "fallback" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

require("go").setup({
	run_in_floaterm = true,
	trouble = true,
	gofmt = "gofumpt",
	lsp_cfg = true,
	lsp_gofumpt = true,
	lsp_onattach = true,
})

require("todo-comments").setup({ signs = true })

require("dressing").setup({
	input = {
		win_options = {
			winhighlight = "NormalFloat:DiagnosticError",
		},
	},
	select = {
		get_config = function()
			return {
				backend = "fzf",
				nui = {
					relative = "cursor",
					max_width = 40,
				},
			}
		end,
	},
})

vim.cmd([[colorscheme mellow]])

-- vim: ft=lua ts=2 sts=2 sw=2 et ai
