local vim = vim
local formatter = require("formatter")
local util = require("formatter.util")
local prettierConfig = function()
  return {
    exe = "npx prettier",
    args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
    stdin = true
  }
end

local formatterConfig = {
  lua = {
    -- function()
    --    return {
    --      exe = "stylua",
    --      args = {  "-" },
    --      stdin = true,
    --    }
    --  end,
    -- function()
    --   return {
    --     exe = "luafmt",
    --     args = {"--indent-count", 2, "--stdin"},
    --     stdin = true
    --   }
    -- end
  },
  vue = {
    function()
      return {
        exe = "prettier",
        args = {
          "--stdin-filepath",
          vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          "--single-quote",
          "--parser",
          "vue"
        },
        stdin = true
      }
    end
  },
  rust = {
    -- Rustfmt
    function()
      return {
        exe = "rustfmt",
        args = {"--emit=stdout"},
        stdin = true
      }
    end
  },
  swift = {
    -- Swiftlint
    function()
      return {
        exe = "swift-format",
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
      }
    end
  },
  r = {
    function()
      return {
        exe = "R",
        args = {
          "--slave",
          "--no-restore",
          "--no-save",
          "-e",
          '\'con <- file("stdin"); styler::style_text(readLines(con)); close(con)\'',
          "2>/dev/null"
        },
        stdin = true
      }
    end
  },
  dart = {
    function()
      return {
        exe = "dart",
        args = {
          'format'
        },
        stdin = true
      }
    end
  },
  sql = {
    function()
        return {
            exe = "sql-formatter",
            args = {
                '--fix',
            }
        }
    end
  },
  ruby = {
    function()
        return {
            -- exe = os.getenv( "HOME" ) .. "/.rbenv/shims/rubocop",
            exe = os.getenv( "RUBOCOP_PATH" ),
            args = {
                "--auto-correct",
                "--format",
                "files",
                "--stdin",
                -- gets the archive name
                util.escape_path(util.get_current_buffer_file_name()),

                -- gets the absolute path
                -- vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
            },
            stdin = true,
            transform = function(text)
                table.remove(text, 1)
                if text[1] == "====================" then
                    table.remove(text, 1)
                end

                return text
            end,
        }
    end
  },
  python = {
    function()
        return {
            exe = "ruff",
            args = {
                "format",
                "--stdin-filename",
                util.escape_path(util.get_current_buffer_file_name()),
            },
            stdin = true,
        }    
    end
  },
  ['*'] = {
      -- require("formatter.filetypes.any").lsp_format,
    -- require('formatter.filetypes.any').remove_trailing_whitespace
  }
}
local commonFT = {
  "css",
  "scss",
  "html",
  -- "java",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "markdown",
  "markdown.mdx",
  "json",
  "yaml",
  "xml",
  "svg",
  "svelte",
  "njk"
}
for _, ft in ipairs(commonFT) do
  formatterConfig[ft] = {prettierConfig}
end
-- Setup functions
formatter.setup(
  {
    logging = true,
    filetype = formatterConfig,
    log_level = 0,
    -- log_level = vim.log.levels.DEBUG,
  }
)

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite 
augroup END
]], false)

vim.keymap.set('n', '<leader>f', '<cmd>FormatWrite<CR>', {})
vim.keymap.set('x', '<leader>f', '<cmd>FormatWrite<CR>', {})

