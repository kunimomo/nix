--[[ plugins ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup ({
  {'preservim/nerdtree'},
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  {'junegunn/fzf'},
  {'junegunn/fzf.vim'}
})

require('toggleterm').setup {
  open_mapping = [[<C-t>]],
  hide_numbers = true,
  shade_terminals = false,
  float_opts = {
    border = 'single',
    width = 100,
    height = 25,
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }, 
  },
  direction = 'float',
}

--[[ options ]]
local options = {
	-- 行番号を表示
	number = true,
	-- コマンドラインモードのステータス表示
	showmode = true,
        -- インデントのスペース数
	shiftwidth = 2,
	-- 検索時に入力と同時に結果がマッチする
	incsearch = true,
	-- 検索時にハイライト
	hlsearch = true,
	-- カーソルのある行をハイライト
	cursorline = true,
	-- カーソルのある列をハイライト
	cursorcolumn = true,
	-- UTF-8でエンコーディング
	encoding = "utf-8",
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

--[[ keymap ]]
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = ' '

-- keymap('i', '{', '{}', opts)
-- keymap('i', '[', '[]', opts)
keymap('i', 'jj', '<ESC>', opts)

-- nerdtree
-- keymap('n', '<C-t>', ':NERDTreeToggle<CR>', opts)

-- fzf.vim
keymap('n', '<Leader>f', ':Files<CR>', opts)
keymap('n', '<Leader>g', ':GFiles<CR>', opts)
keymap('n', '<Leader>G', ':GFiles?<CR>', opts)
