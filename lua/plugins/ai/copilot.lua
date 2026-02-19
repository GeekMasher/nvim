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
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- model = "gpt-4.1", -- AI model to use
      temperature = 0.1, -- Lower = focused, higher = creative
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.5, -- 50% of screen width
      },
      auto_insert_mode = true, -- Enter insert mode when opening
    },
    config = function(opts)
      require("CopilotChat").setup(opts)
      -- Key mappings for Copilot Chat
      vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>CopilotChat<CR>", { noremap = true, silent = true })
    end,
  },
}
