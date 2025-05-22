--[[

    LSP Configuration (the magic happens here)

Resources:
- https://github.com/nvim-lua/kickstart.nvim/blob/5e258d276fef52cc45a17021dc83a95748a0bc7f/init.lua#L423-L451

--]]

return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Mason is amazing
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			"j-hui/fidget.nvim",
			"folke/neodev.nvim",
			-- TypeScript
			"pmizio/typescript-tools.nvim",
			-- VueJS
			"posva/vim-vue",
		},
		config = function(_, opts)
			-- On attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("geekmasher-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("geekmasher-lsp-highlight", { clear = false })
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
							group = vim.api.nvim_create_augroup("geekmasher-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "geekmasher-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Setup capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				-- Rust
				rust_analyzer = function()
					return true
				end,
				-- Python
				pyright = {},
				-- GoLang
				gopls = {},
				-- Web Dev
				ts_ls = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = function()
									local node_modules = "/usr/local/lib/node_modules/"
									-- For NVM users
									if os.getenv("NVM_BIN") then
										node_modules = os.getenv("NVM_BIN") .. "../lib/node_modules/"
									end
									vim.print("Using node_modules: " .. node_modules)
									return node_modules .. "@vue/typescript-plugin"
								end,
								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
					filetypes = {
						"javascript",
						"typescript",
						"vue",
					},
				},
				html = {},
				-- htmx = {},
				tailwindcss = {},
				-- Bash
				bashls = {},
				-- Markdown Languages
				jsonls = {},
				yamlls = {},
				-- Docker
				dockerls = {},
				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			-- message to user
			vim.notify("Installing LSP servers: " .. table.concat(ensure_installed, ", "), vim.log.levels.INFO)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	-- Auto format
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>af",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[A]uto [F]ormat",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			-- Formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
			},
		},
	},
}
