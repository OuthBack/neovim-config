--[[
Implements 4 methods:
  get_current_method_name() - return a method name.
  get_current_class_name() - return a class name where the cursor is
  get_current_package_name() - return a package name of the current file
  get_current_full_class_name() - return a full class name (package + class name)
  get_current_full_method_name(delimiter) - return a full method name (package + class + [delimiter] + method name)
--]]

local ts_M = require'nvim-treesitter.ts_utils'

local M = {}

-- Find nodes by type
function find_node_by_type(expr, type_name)
  while expr do
    if expr:type() == type_name then
        break
    end
    expr = expr:parent()
  end
  return expr
end

-- Find child nodes by type
function find_child_by_type(expr, type_name)
  local id = 0
  local expr_child = expr:child(id)
  while expr_child do 
    if expr_child:type() == type_name then
      break
    end
    id = id + 1
    expr_child = expr:child(id)
  end

  return expr_child
end

-- Get Current Method Name
function M.get_current_method_name()
  local current_node = ts_M.get_node_at_cursor()
  if not current_node then return nil end

  local expr = find_node_by_type(current_node, 'method_declaration')
  if not expr then return nil end

  local child = find_child_by_type(expr, 'identifier')
  if not child then return nil end
  return vim.treesitter.query.get_node_text(child, 0)
end

-- Get Current Class Name
function M.get_current_class_name()
  local current_node = ts_M.get_node_at_cursor()
  if not current_node then return nil end

  local class_declaration = find_node_by_type(current_node, 'class_declaration')
  if not class_declaration then return nil end
  
  local child = find_child_by_type(class_declaration, 'identifier')
  if not child then return nil end
  return vim.treesitter.query.get_node_text(child, 0)
end

-- Get Current Package Name
function M.get_current_package_name()
  local current_node = ts_M.get_node_at_cursor()
  if not current_node then return nil end

  local program_expr = find_node_by_type(current_node, 'program')
  if not program_expr then return nil end
  local package_expr = find_child_by_type(program_expr, 'package_declaration')
  if not package_expr then return nil end

  local child = find_child_by_type(package_expr, 'scoped_identifier')
  if not child then return nil end
  return vim.treesitter.query.get_node_text(child, 0)
end

-- Get Current Full Class Name
function M.get_current_full_class_name()
  local package = M.get_current_package_name()
  local class = M.get_current_class_name()
  return package .. '.' .. class
end

-- Get Current Full Method Name with delimiter or default '.'
function M.get_current_full_method_name(delimiter)
  delimiter = delimiter or '.'
  local full_class_name = M.get_current_full_class_name()
  local method_name = M.get_current_method_name()
  return full_class_name .. delimiter .. method_name
end


-----------------------------------------------------------
---Key Map

local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

function get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end 

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function run_spring_boot(debug)
  vim.cmd('term ' .. get_spring_boot_runner('local', debug))
end

-- run debug
function get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"' 
  end
  return 'mvn test -Dtest="' .. test_name .. '"' 
end

function run_java_test_method(debug)
  local method_name = M.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function run_java_test_class(debug)
  local class_name = M.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

vim.keymap.set("n", "<leader>rsb", function() run_spring_boot() end)
vim.keymap.set("n", "<leader>rsbd", function() run_spring_boot(true) end)
vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
vim.keymap.set("n", "<leader>dtm", function() run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
vim.keymap.set("n", "<leader>dtc", function() run_java_test_class(true) end)
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')
key_map('n', '<leader>dc', ':lua require"dap".continue()<CR>')
key_map('n', '<leader>dsov', ':lua require"dap".step_over()<CR>')
key_map('n', '<leader>dsi', ':lua require"dap".step_into()<CR>')
key_map('n', '<leader>dso', ':lua require"dap".step_out()<CR>')
key_map('n', '<leader>da', ':lua attach_to_debug()<CR>')

return M