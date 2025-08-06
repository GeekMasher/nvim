--[[
 _____  ___    _______    ______  ___      ___  __     ___      ___
(\"   \|"  \  /"     "|  /    " \|"  \    /"  ||" \   |"  \    /"  |
|.\\   \    |(: ______) // ____  \\   \  //  / ||  |   \   \  //   |
|: \.   \\  | \/    |  /  /    ) :)\\  \/. ./  |:  |   /\\  \/.    |
|.  \    \. | // ___)_(: (____/ //  \.    //   |.  |  |: \.        |
|    \    \ |(:      "|\        /    \\   /    /\  |\ |.  \    /:  |
 \___|\____\) \_______) \"_____/      \__/    (__\_|_)|___|\__/|___|

Author: GeekMasher

Resources:
- https://github.com/nvim-lua/kickstart.nvim

-- ]]

-- https://github.com/folke/lazy.nvim
-- Install Lazy if not present on the system
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Font
vim.g.have_nerd_font = true

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show mode
vim.opt.showmode = false
-- Clipboard shared
vim.opt.clipboard = "unnamedplus"

-- Other
vim.opt.breakindent = true
vim.opt.title = true
vim.opt.laststatus = 2
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

-- Mouse (No Mouse)
vim.opt.mouse = ""

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Screen lines
vim.opt.scrolloff = 10

-- Backup / Swap
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

-- Shell used
vim.opt.shell = "zsh"
vim.opt.cmdheight = 1
vim.opt.showcmd = false

-- Tab magic
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- No Wrap lines
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Find files
vim.opt.path:append({ "**" })
-- Ignore Files
vim.opt.wildignore:append({
	-- Git
	"**/.git/*",
	-- Python
	"**/.pyc",
	-- Rust
	"**/target/",
	-- JS/TS
	"*/node_modules/*",
	-- Mobile
	"**/ios/*",
	"**/android/*",
})

local opts = { noremap = true, silent = true }

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Centralise Jumping
vim.keymap.set("n", "j", "jzz", opts)
vim.keymap.set("n", "k", "kzz", opts)

vim.keymap.set("n", "J", "20jzz", opts)
vim.keymap.set("n", "K", "20kzz", opts)

vim.keymap.set("n", "L", "w", opts)
vim.keymap.set("n", "H", "b", opts)

-- Disable Arrow Keys (you have to learn some day)
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
-- Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- LSP
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#default-keybindings
-- vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
-- vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>")
-- vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
--
-- vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>")
-- vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
-- vim.keymap.set("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
--
-- vim.keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
-- vim.keymap.set("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")
--
-- vim.keymap.set("n", "<leader>o", vim.diagnostic.open_float, opts)

-- TODO Expand Rust Macros
vim.keymap.set("n", "<leader>ge", '<cmd>lua vim.cmd.RustLsp("expandMacro")<cr>')

-- Lazy man's saving...
vim.keymap.set("n", "qq", "<cmd>:wq<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr>")

-- Reselect the visual selections
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Lazy Plugins
require("lazy").setup("plugins")
