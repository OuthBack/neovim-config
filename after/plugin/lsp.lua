local nvim_lsp = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(client, bufnr)
        -- Create your keybindings here..."
        local fmt = function(cmd) return function(str) return cmd:format(str) end end
        local lsp = fmt('<cmd>lua vim.lsp.%s<cr>')
        local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')
        local opts = { buffer = bufnr, remap = false }

        local map = function(m, lhs, rhs)
            vim.keymap.set(m, lhs, rhs, opts)
        end

        map('n', 'K', lsp 'buf.hover()')
        map('n', 'gd', lsp 'buf.definition()')
        map('n', 'gD', lsp 'buf.declaration()')
        map('n', 'gi', lsp 'buf.implementation()')
        map('n', 'gt', lsp 'buf.type_definition()')
        map('n', 'gr', lsp 'buf.references()')
        map('n', 'gs', lsp 'buf.signature_help()')
        map('n', '<F2>', lsp 'buf.rename()')
        map('n', '<F3>', lsp 'buf.format({async = true})')
        map('x', '<F3>', lsp 'buf.format({async = true})')
        map('n', '<leader>ca', lsp 'buf.code_action()')

        if vim.lsp.buf.range_code_action then
            map('x', '<F4>', lsp 'buf.range_code_action()')
        else
            map('x', '<F4>', lsp 'buf.code_action()')
        end

        map('n', 'gl', diagnostic 'open_float()')
        map('n', '[d', diagnostic 'goto_prev()')
        map('n', ']d', diagnostic 'goto_next()')
        map('n', '<leader>lws', diagnostic 'workspace_symbol()')
        map("n", "<leader>vd", diagnostic 'workspace_symbol()')
        map("n", "<leader>vd", diagnostic 'open_float()')
        map("n", "[d", diagnostic 'goto_next()')
        map("n", "]d", diagnostic 'goto_prev()')
        map("n", "<leader>vca", diagnostic 'code_action()')
        map("n", "<leader>vvr", diagnostic 'references()')
        map("n", "<leader>vrn", diagnostic 'rename()')
        map("i", "<-h>", diagnostic 'signature_help()')
    end
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        -- 'lua_ls',
        'svelte',
        'prismals',
        'cssls',
        'angularls',
        -- Solargraph is down below
    }
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
    function(server_name)
        if server_name == 'yamlls' then
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities, settings = {                                                                                                           
                    yaml = {                                                                                                           
                        hover = true,                                                                                                  
                        format = {                                                                                                     
                            enable = true,                                                                                             
                            singleQuote = true,                                                                                        
                        },                                                                                                             
                        completion = true,                                                                                             
                        validate = true,                                                                                               
                        customTags = { '!Ref scalar' },                                                                       
                        schemas = {                                                                                                    
                            ["https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json"]= "/*",   
                        },                                                                                                             
                        schemaStore = {                                                                                                
                            enable = true,                                                                                             
                        },                                                                                                             
                    },                                                                                                                 
                }          

            })
            return
        end

        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end,
})

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true
        }
    )
}

nvim_lsp.dartls.setup({
  cmd = { "dart", 'language-server', '--protocol=lsp' },
})

nvim_lsp.lua_ls.setup{
    cmd = { "lua-language-server" }
}

nvim_lsp.pyright.setup({
    settings = {
        python = {
            pythonPath = vim.fn.exepath("python3"),
        },
    },
})

--  TODO: RUBOCOP NEEDS TO BE INSTALLED GLOBALLY
-- nvim_lsp.rubocop.setup({
--     cmd = { os.getenv( "RUBOCOP_PATH" ),  "--lsp" }
-- })

nvim_lsp.solargraph.setup {
    cmd = {
        "solargraph",
        "stdio"
    },
    filetypes = {
        "ruby"
    },
    flags = {
        debounce_text_changes = 150
    },
    --on_attach = on_attach,
    root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
    capabilities = capabilities,
    handlers = handlers,
    settings = {
        solargraph = {
            completion = true,
            autoformat = false,
            formatting = true,
            symbols = true,
            definitions = true,
            references = true,
            folding = true,
            highlights = true,
            diagnostics = true,
            rename = true,
            -- Enable this when running with docker compose
            --transport = 'external',
            --externalServer = {
            --    host = 'localhost',
            --    port = '7658',
            --}
        }
    }
}
