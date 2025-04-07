-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', }
  use "nvim-lua/plenary.nvim"
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim', tag='v0.1.3'} }
  }
  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }
  use{'dracula/vim'} -- No versions
  use{'nvim-treesitter/nvim-treesitter', run=':TSUpdate' } -- tag='v0.9.2'}
  use{'nvim-treesitter/playground'} -- No versions
  use{'mbbill/undotree', tag='rel_6.1'} 
  use{'tpope/vim-fugitive', tag='v3.7'}
  use {
    'sudormrfbin/cheatsheet.nvim',
    -- No tags
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
  -- use {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v2.x',
  --   requires = {
  --       -- LSP Support
  --       {'neovim/nvim-lspconfig'},             -- Required
  --       {                                      -- Optional
  --       'williamboman/mason.nvim',
  --       run = function()
  --         pcall(vim.cmd, 'MasonUpdate')
  --       end,
  --     },
  --     {'williamboman/mason-lspconfig.nvim'}, -- Optional
  --
  --     -- Autocompletion
  --     {'hrsh7th/nvim-cmp'},     -- Required
  --     {'hrsh7th/cmp-nvim-lsp'}, -- Required
  --     {'L3MON4D3/LuaSnip'},     -- Required
  --   }
  -- }
  --
  use{
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v2.1.1", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
    }
    use {
        "hrsh7th/nvim-cmp", -- Few Tags
    }
  use { 'saadparwaiz1/cmp_luasnip' } -- No tags
  use {
    'williamboman/mason.nvim',
    tag = 'v1.6.0',
    run = ":MasonUpdate",
    config = function ()
      require('mason').setup()
    end
  }
  use {'mfussenegger/nvim-dap', tags='0.6.0'}
  use {"rcarriga/nvim-dap-ui", tags='v3.9.3', requires = {"mfussenegger/nvim-dap"} }
  use {"theHamsta/nvim-dap-virtual-text"} -- No tags
  use {
    "williamboman/mason-lspconfig.nvim",
    tag='v1.11.0'
  }
  use {
    'neovim/nvim-lspconfig',
    tags='v0.1.6'
  }
  use {
      'hrsh7th/cmp-nvim-lsp'
  }
  use {
    "zbirenbaum/copilot.lua",
    -- No tags
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    -- No tags
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  -- use {"akinsho/toggleterm.nvim", 
  --   tag = 'v2.7.1', 
  --   config = function()
  --   require("toggleterm").setup()
  -- end}
  -- use {'neoclide/coc.nvim',
  --   tags='0.0.82',
  --   branch = 'release'
  -- }
  use {
    tags='3.8.2',
    "lukas-reineke/indent-blankline.nvim"
  }
  -- use {tags='0.42.0','junegunn/fzf'}
  -- use 'junegunn/fzf.vim' -- No tags
  use{"folke/todo-comments.nvim",
    tags='stable',
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }
  -- use {'m4xshen/autoclose.nvim'} -- No tags
  use {'gelguy/wilder.nvim',} -- No Tags
  use {'romgrk/fzy-lua-native',} -- No Tags
  use {
    'numToStr/Comment.nvim',
    tags='0.8.0',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'windwp/nvim-ts-autotag', -- No tags
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }
  -- use {'mfussenegger/nvim-jdtls', tags='0.2.0' }
  use "rafamadriz/friendly-snippets" -- No tags
  use {
      "kylechui/nvim-surround",
      tag = "v2.1.0", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  }
  use 'rcarriga/cmp-dap' -- No tags
  use { 'mhartington/formatter.nvim' } -- No tags
  use {"ThePrimeagen/lsp-debug-tools.nvim"} -- No tags
  -- DEBUGGER ADAPTERS
  use {
      "microsoft/vscode-js-debug",
      opt = true,
      run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
  }
  use {
      "mxsdev/nvim-dap-vscode-js",
      tag = "v1.1.0",
      requires = {"mfussenegger/nvim-dap"}
  }
use {
    'akinsho/flutter-tools.nvim', -- No Tags
    requires = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
        require("flutter-tools").setup {} -- use defaults
    end
}
use { 'rcarriga/nvim-notify', tags='v3.14.0'}
use {
    'rareitems/printer.nvim',
    config = function()
        require('printer').setup({
            keymap = "<leader>l" -- Plugin doesn't have any keymaps by default
          })
    end
}
use { 'MeanderingProgrammer/render-markdown.nvim', tags='v7.5.0' }
use { 'nvim-treesitter/nvim-treesitter-context' }

end)

