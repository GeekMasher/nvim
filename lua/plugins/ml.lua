-- https://github.com/github/copilot.vim
-- https://github.com/zbirenbaum/copilot.lua

return {
    {
        "zbirenbaum/copilot.lua",
        event = "VeryLazy",
        dependencies = {
            "zbirenbaum/copilot-cmp",
        },
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-a>",
                    },
                },
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    hide_during_completion = true,
                    keymap = {
                        accept = "<C-a>",
                        open = "<F11>",
                    },
                    layout = {
                        position = "right",
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    dotfile = false,
                },
            })

            require("copilot_cmp").setup()
        end,
    },
    {
        "David-Kunz/gen.nvim",
        event = "VeryLazy",
        opts = {
            model = "codellama",
            display_mode = "float", -- The display mode. Can be "float" or "split".
            show_prompt = true, -- Shows the Prompt submitted to Ollama.
            show_model = true, -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = false, -- Never closes the window automatically.
            command = 'ask-ai -m="$model" "$prompt"',
        },
    },
}
