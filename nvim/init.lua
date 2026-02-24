vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.g.mapleader = " "
vim.o.clipboard = 'unnamedplus'
vim.filetype.add({ extension = { prisma = "prisma" } })

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/NeogitOrg/neogit" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-mini/mini.statusline" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-mini/mini.tabline" },
})

-- ============================================================
-- 플러그인 설정
-- ============================================================

-- nvim-tree (VSCode 스타일 트리 탐색기)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require "nvim-web-devicons".setup()
require "nvim-tree".setup({
	view = {
		width = 30,
		side = "left",
	},
	renderer = {
		indent_markers = { enable = true },
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
	},
	actions = {
		open_file = {
			quit_on_open = false,
			window_picker = { enable = true },
		},
	},
	on_attach = function(bufnr)
		local api = require "nvim-tree.api"
		api.config.mappings.default_on_attach(bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }
		local function open_in_split(split_cmd)
			local node = api.tree.get_node_under_cursor()
			if not node or node.type ~= 'file' then return end
			local path = vim.fn.fnameescape(node.absolute_path)
			-- nvim-tree 외 편집 윈도우 찾기
			local tree_win = vim.api.nvim_get_current_win()
			local target_win = nil
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				if win ~= tree_win and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == '' then
					target_win = win
					break
				end
			end
			if target_win then
				vim.api.nvim_set_current_win(target_win)
				vim.cmd(split_cmd .. ' ' .. path)
			else
				-- 편집 윈도우가 없으면 nvim-tree 우측에 그냥 열기
				vim.cmd('wincmd l')
				vim.cmd('edit ' .. path)
			end
		end
		vim.keymap.set('n', '-', function() open_in_split('split') end, opts)
		vim.keymap.set('n', '\\', function() open_in_split('vsplit') end, opts)
	end,
})

-- Statusline
require "mini.statusline".setup()

-- Auto close pair characters
require "mini.pairs".setup()

-- Tabline (열린 버퍼 목록 표시)
require "mini.tabline".setup()

-- Mini pick (fuzzy finder)
require "mini.pick".setup({
	mappings = {
		choose_in_split = '-',
		choose_in_vsplit = '\\',
	}
})

-- 자동완성 (blink.cmp)
require "blink.cmp".setup({
	keymap = {
		preset = 'default',
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide' },
		['<CR>'] = { 'accept', 'fallback' },
		['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
		['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
	},
	completion = {
		documentation = { auto_show = true },
		menu = {
			draw = {
				columns = { { 'kind_icon' }, { 'label', gap = 1 } },
			},
		},
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
})

-- Treesitter (구문 하이라이팅, 들여쓰기, 코드 접기)
require "nvim-treesitter".install({
	"lua", "python", "javascript", "typescript", "tsx",
	"json", "html", "css", "yaml", "dockerfile",
	"terraform", "sql", "c", "cpp", "rust",
	"bash", "markdown", "toml", "vim", "vimdoc",
	"svelte", "prisma", "erlang", "elixir", "heex",
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldenable = false

-- Neogit (Git 관리)
require "neogit".setup({
	kind = "floating",
	integrations = {
		diffview = true,
	},
})

-- Diffview (변경 파일 목록 + diff 미리보기)
require "diffview".setup()

-- Gitsigns (줄 단위 Git 변경 표시)
require "gitsigns".setup()

-- 포매터 (conform.nvim)
require "conform".setup({
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		javascriptreact = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		terraform = { "terraform_fmt" },
		sql = { "sql_formatter" },
		svelte = { "prettier" },
	},
})

-- LSP + Mason
local language_server_list = { "lua_ls", "pyright", "jsonls", "html", "cssls", "yamlls", "dockerls", "terraformls", "sqlls", "clangd", "rust_analyzer", "ts_ls", "svelte", "prismals", "erlangls", "elixirls" }
require "mason".setup()
require "mason-lspconfig".setup({
	ensure_installed = language_server_list
})
require "mason-tool-installer".setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"ruff",
		"sql-formatter",
	},
})
vim.lsp.enable(language_server_list)

-- ============================================================
-- Which-key (키맵 그룹 정의)
-- ============================================================

require "which-key".setup()
require "which-key".add({
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>w", group = "Window" },
})

-- ============================================================
-- 키맵
-- ============================================================

-- 기본
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit', silent = true })
vim.keymap.set('n', '<leader>s', ':write<CR>', { desc = 'Save', silent = true })

-- 파일 탐색기
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Explorer', silent = true })

-- 버퍼
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close buffer', silent = true })

-- Find (검색)
vim.keymap.set('n', '<leader>ff', MiniPick.builtin.files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fg', MiniPick.builtin.grep_live, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, { desc = 'Buffers' })

-- Git
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Neogit', silent = true })
vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { desc = 'Commit', silent = true })
vim.keymap.set('n', '<leader>gp', ':Neogit push<CR>', { desc = 'Push', silent = true })
vim.keymap.set('n', '<leader>gl', ':Neogit pull<CR>', { desc = 'Pull', silent = true })
vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = 'Diff', silent = true })
vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { desc = 'File history', silent = true })
vim.keymap.set('n', '<leader>gq', ':DiffviewClose<CR>', { desc = 'Close diff', silent = true })

-- LSP
vim.keymap.set('n', '<leader>lf', function()
	require "conform".format({ lsp_format = "fallback" })
end, { desc = 'Format' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Diagnostics' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { desc = 'Implementation' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Window (창 관리)
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Horizontal split', silent = true })
vim.keymap.set('n', '<leader>wx', ':close<CR>', { desc = 'Close window', silent = true })
vim.keymap.set('n', '<leader>w<Up>', ':resize +2<CR>', { desc = 'Height +', silent = true })
vim.keymap.set('n', '<leader>w<Down>', ':resize -2<CR>', { desc = 'Height -', silent = true })
vim.keymap.set('n', '<leader>w<Left>', ':vertical resize +2<CR>', { desc = 'Width +', silent = true })
vim.keymap.set('n', '<leader>w<Right>', ':vertical resize -2<CR>', { desc = 'Width -', silent = true })

-- 창 이동 (Ctrl + h/j/k/l)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Visual 모드 줄 이동
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- ============================================================
-- 테마 & UI
-- ============================================================

vim.cmd("colorscheme kanagawa-dragon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#b8b4a8", bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f2d78b", bold = true, bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#76946a", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#dca561", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#c34043", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#e82424", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#ff9e3b", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#658594", bg = "none" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#6a9589", bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- 창 구분선
vim.o.fillchars = "vert:│,horiz:─,horizup:┴,horizdown:┬,vertleft:┤,vertright:├,verthoriz:┼"
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#54546d", bg = "none" })

-- ============================================================
-- 터미널
-- ============================================================

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0
		vim.cmd("startinsert")
	end,
})

vim.keymap.set('n', '<C-`>', function()
	vim.cmd("botright split | terminal")
	vim.cmd("resize 15")
end, { desc = 'Terminal', silent = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Terminal normal mode' })
vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Window left' })
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Window down' })
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Window up' })
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Window right' })
