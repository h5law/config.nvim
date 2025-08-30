---@diagnostic disable: undefined-global
local vim = vim

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]definition")

		map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

		map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

		map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]definition")

		map("<leader>K", require("fzf-lua").lsp_definitions, "Fzf Lsp Definitions")

		map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]symbols")

		map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]symbols")

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>cA", require("fzf-lua").lsp_code_actions, "Fzf [C]ode [A]ction")

		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({
						group = "lsp-highlight",
						buffer = event2.buf,
					})
				end,
			})
		end
	end,
})

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
local util = require("lspconfig.util")

-- local ccls_root = vim.fs.dirname(
--     vim.fs.find({
--         ".ccls",
--         ".clang-format",
--         "compile_commands.json",
--         "compile_flags.txt",
--         ".git"
--     }, { upward = true })[1]);

-- ---@diagnostic disable: unused-vararg
-- local ccls_opts = {
--     init_options = {
--       codelens = {
--         enable = true,
--         events = { "BufEnter", "BufWritePost" },
--       },
--       compilationDatabaseDirectory =  { ccls_root },
--       index = {
--         threads = 2,
--       },
--       cache = {
--         enable = true,
--         directory = ".cache/ccls",
--       },
--       root_dir = ccls_root,
--   },
-- }
-- require("ccls").setup(ccls_opts);

local servers = {
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
			"--all-scopes-completion",
			"--header-insertion=iwyu",
			"--import-insertions",
			"--header-insertion-decorators",
			"--function-arg-placeholders=1",
			"--offset-encoding=utf-8",
		},
		filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
		root_dir = vim.fs.dirname(vim.fs.find({
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			".git",
		}, { upward = true })[1]),
		settings = {
			init_options = {
				clangdFileStatus = true,
				usePlaceholders = true,
				completeUnimported = true,
				semanticHighlighting = true,
			},
		},
	},

	-- ccls = {
	--   cmd = { "ccls" },
	--   filetypes = { "c", "cpp", "objc", "objcpp", "opencl"  },
	--   single_file_support = true,
	--   root_dir = { ccls_root },
	--   settings = { ccls_opts },
	--   capabilities = capabilities,
	-- },

	gopls = require("go.lsp").config(),
	-- gopls = {
	-- cmd = { "gopls" },
	-- filetypes = { "go", "gomod", "gowork", "gotmpl" },
	-- root_dir = { util.root_pattern(".git", "go.mod", "go.work") },
	-- capabilities = capabilities,
	-- setting = {
	--   gopls = {
	--     analyses = {
	--       nilness = true,
	--       unusedparams = true,
	--       unusedwrite = true,
	--       useany = true,
	--     },
	--     experimentalPostfixCompletions = true,
	--     gofumpt = true,
	--     staticcheck = true,
	--     usePlaceholders = true,
	--   },
	-- },
	-- },

	rust_analyzer = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_dir = { lspconfig.util.root_pattern("Cargo.toml") },
		capabilities = capabilities,
	},

	zls = {
		cmd = { "zls" },
		filetypes = { "zig" },
		root_dir = { util.root_pattern("build.zig", ".git") },
		capabilities = capabilities,
		docs = {
			description = [[ ]],
			default_config = {
				root_dir = [[root_pattern("build.zig", ".git")]],
			},
		},
	},

	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		capabilities = capabilities,
		settings = {
			globals = {
				"vim",
				"vim.g",
				"vim.opt",
				"vim.cmd",
				"vim.keymap",
			},
		},
	},

	asm_lsp = {
		cmd = { "asm-lsp" },
		filetypes = { "asm", "s", "S" },
		capabilities = capabilities,
		root_dir = {
			vim.fs.dirname(vim.fs.find({
				".asm-lsp.toml",
				"compile_commands.json",
				"compile_flags.txt",
				".git",
			}, { upward = true })[1]),
		},
	},
}

for server_name in pairs(servers) do
	local config = servers[server_name]
	config.capabilities = capabilities
	config.capabilities.positionEncoding = "utf-32"
	require("lspconfig")[server_name].setup(config)
end

-- vim: ft=lua ts=2 sts=2 sw=2 et ai
