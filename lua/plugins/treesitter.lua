--- TreeSitter setup
---

--- Tools to install
local tools = {
  "rust",
  "python",
  "bash",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "xml",
  "yaml",
  "ql",
  "dockerfile",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    branch = "main",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      ensure_installed = tools,
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "VeryLazy" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = { set_jumps = true },
      })
    end,
  },
}
