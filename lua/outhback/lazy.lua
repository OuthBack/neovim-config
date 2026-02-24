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

require("lazy").setup({
    -- Utilitários
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.5",
        dependencies = { { "nvim-lua/plenary.nvim", version = "0.1.3" } },
     Lark},

    -- Navegação e UI
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "dracula/vim" },
    { "mbbill/undotree", version = "rel_6.1" },
    { "tpope/vim-fugitive", version = "v3.7" },
    { "romgrk/fzy-lua-native" },
    { "rcarriga/nvim-notify", version = "v3.14.0" },
    { "chentoast/marks.nvim" },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- version = "v0.9.2" -- Opcional, descomente se necessário
     Lark},
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-context" },

    -- Cheatsheet
    {
        "sudormrfbin/cheatsheet.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
    },

    -- LSP e Completamento
    {
        "L3MON4D3/LuaSnip",
        version = "v2.1.1",
        build = "make install_jsregexp",
    },
    { "hrsh7th/nvim-cmp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "rafamadriz/friendly-snippets" },
    {
        "williamboman/mason.nvim",
        version = "v1.6.0",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    { "williamboman/mason-lspconfig.nvim", version = "v2.1.0" },
    { "neovim/nvim-lspconfig", version = "v2.5.0" },
    { "simrat39/rust-tools.nvim" },
    { "ThePrimeagen/lsp-debug-tools.nvim" },

    -- Debugger (DAP)
    { "mfussenegger/nvim-dap", version = "0.6.0" },
    {
        "rcarriga/nvim-dap-ui",
        version = "v3.9.3",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } -- nvim-nio é agora obrigatório para dap-ui
    },
    { "theHamsta/nvim-dap-virtual-text" },
    { "rcarriga/cmp-dap" },
    -- {
    --     "microsoft/vscode-js-debug",
    --     lazy = true,
    --     build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    -- },
    {
        "mxsdev/nvim-dap-vscode-js",
        version = "v1.1.0",
        dependencies = { "mfussenegger/nvim-dap" },
    },

    -- Edição e Formatação
    { "lukas-reineke/indent-blankline.nvim", version = "3.8.2" },
    {
        "folke/todo-comments.nvim",
        version = "stable",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}, -- Chama setup() automaticamente
    },
    { "gelguy/wilder.nvim" },
    {
        "numToStr/Comment.nvim",
        version = "0.8.0",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "v2.1.0",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    { "mhartington/formatter.nvim" },

    -- Ferramentas Específicas
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function()
            require("flutter-tools").setup({})
        end,
    },
    {
        "rareitems/printer.nvim",
        config = function()
            require("printer").setup({
                keymap = "<leader>l",
            })
        end,
    },
    { "MeanderingProgrammer/render-markdown.nvim", version = "v7.5.0" },
    { "chrisgrieser/nvim-early-retirement" },
    {
        "Zeioth/garbage-day.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "Zeioth/hot-reload.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            local config_dir = vim.fn.stdpath("config")
            return {
                reload_files = {
                    config_dir .. "lua/outhback/remap.lua",
                },
                reload_callback = function()
                    vim.cmd(":silent! colorscheme " .. vim.g.default_colorscheme)
                    vim.cmd(":silent! doautocmd ColorScheme")
                end,
            }
        end,
    },
})
