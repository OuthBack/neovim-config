return {
  cmd = { "devsense-php-ls", "--stdio" },
  filetypes = { "php" },
  -- Optional: Pass your DevSense JSON premium license if you have one
  init_options = {
    -- ["0"] = "{YOUR_JSON_SIGNATURE_HERE}" 
  },
  settings = {
    -- Custom PHP settings can go here
  }
}
