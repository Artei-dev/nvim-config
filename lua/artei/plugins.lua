local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Core Plugins
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use 'goolord/alpha-nvim'
  use "lukas-reineke/indent-blankline.nvim"

  -- Colorschemes
  use "sainnhe/everforest"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- the completion plugin
  use "hrsh7th/cmp-buffer" 
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
-- LSP
  use "neovim/nvim-lspconfig"  
  use "williamboman/nvim-lsp-installer" -- server installer
  use "jose-elias-alvarez/null-ls.nvim" -- server installer
  use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim" 
  use "nvim-telescope/telescope-media-files.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"

  -- Lualine
  use "kyazdani42/nvim-web-devicons"
  use {
    "nvim-lualine/lualine.nvim",
    requries = { "kyazdani42/nvim-web-devicons", opt = true }
  }
  -- Terminal Stuff
  use "akinsho/toggleterm.nvim"
   
  -- Discord rich presence
  use 'andweeb/presence.nvim'

  -- Language support
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
