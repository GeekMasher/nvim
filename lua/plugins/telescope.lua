--- Check if a file or directory exists in this path
---@param file any
---@return boolean
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

--- Get the ignore files from .vimignore
---@return table
local function get_ignore_files()
	local files = {
		".git/",
		".vscode/",
		-- General Coding folders
		"bin/",
		-- JS / Node
		"node_modules/",
		"dist/",
		-- Python
		".pyc",
		".venv/",
		-- Rust
		"target/",
		"Cargo.lock",
	}
	-- Read from file
	local file = ".vimignore"
	if not file_exists(file) then
		return files
	end
	for line in io.lines(file) do
		if line == nil or line == "" then
			line = ""
		else
			files[#files + 1] = line
		end
	end
	return files
end

return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			local actions = require("telescope.actions")
			local sorters = require("telescope.sorters")
			local previewers = require("telescope.previewers")

			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_sorter = sorters.get_fzy_sorter,

					prompt_prefix = "🔍 ",
					hidden = true,
					color_devicons = true,

					-- Custom ignore files func
					file_ignore_patterns = get_ignore_files(),

					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Load extensions
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "file_browser")

			-- Telescope Keybindings
			local telescope_builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", function()
				-- Show hidden and ignored files
				telescope_builtin.find_files({ hidden = true, no_ignore = true })
			end)
			vim.keymap.set("n", "<leader>fg", function()
				telescope_builtin.live_grep()
			end)
			vim.keymap.set("n", "<leader>fd", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = vim.fn.expand("%:p:h"),
					respect_gitignore = true,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "insert",
					layout_config = { height = 40 },
				})
			end)

			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
		end,
	},
}
