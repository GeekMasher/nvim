--[[

    LSP Configuration (the magic happens here)

Resources:
- https://github.com/nvim-lua/kickstart.nvim/blob/5e258d276fef52cc45a17021dc83a95748a0bc7f/init.lua#L423-L451

--]]

return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Mason is amazing
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            "j-hui/fidget.nvim",
            "folke/neodev.nvim",

            "pmizio/typescript-tools.nvim",

            -- Rust
            "mrcjkb/rustaceanvim",
            -- VueJS
            "posva/vim-vue",
        },
        opts = {
            -- LSP Servers Configuration
            setup = {
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
                volar = {},
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
                        },
                    },
                },
            },
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

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Setup Mason
            require("mason").setup()

            local ensure_installed = vim.tbl_keys(opts.setup or {})
            vim.list_extend(ensure_installed, {
                "stylua",
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = opts.setup[server_name] or {}
                        if type(server) == "boolean" or type(server) == "function" then
                            -- Skip if server loading
                        else
                            -- This handles overriding only values explicitly passed
                            -- by the server configuration above. Useful when disabling
                            -- certain features of an LSP (for example, turning off formatting for tsserver)
                            server.capabilities =
                                vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                            require("lspconfig")[server_name].setup(server)
                        end
                    end,
                },
            })
        end,
    },
    -- Auto format
    {
        "stevearc/conform.nvim",
        lazy = false,
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
            },
        },
    },
}
