vim.cmd([[packadd lspsaga.nvim]])

--[[ Built-in LSP Appearance ]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false,
  -- virtual_text = {
  --   prefix = "»",
  --   spacing = 4,
  -- },
  signs = { priority = 20 },
  update_in_insert = false,
})

-- vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsDefaultError" })
-- vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", texthl = "LspDiagnosticsDefaultWarning" })
-- vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", texthl = "LspDiagnosticsDefaultInformation" })
-- vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", texthl = "LspDiagnosticsDefaultHint" })

local lspconfig = require("lspconfig")
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga({
  use_saga_diagnostic_sign = true,
  code_action_icon = "",
  code_action_prompt = {
    enable = true,
    sign = false,
    virtual_text = true,
  },
})

local custom_on_attach = function(bufnr)
  local api = vim.api
  local kopts = { noremap = true, silent = true }
  api.nvim_set_keymap("n", "gh", [[:Lspsaga lsp_finder<CR>]], kopts)
  api.nvim_set_keymap("n", "ga", [[:Lspsaga code_action<CR>]], kopts)
  api.nvim_set_keymap("v", "ga", [[:Lspsaga range_code_action<CR>]], kopts)
  api.nvim_set_keymap("n", "K", [[:Lspsaga hover_doc<CR>]], kopts)
  api.nvim_set_keymap("n", "<C-f>", [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>]], kopts)
  api.nvim_set_keymap("n", "<C-b>", [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>]], kopts)
  api.nvim_set_keymap("n", "gs", [[:Lspsaga signature_help<CR>]], kopts)
  api.nvim_set_keymap("n", "gr", [[:Lspsaga rename<CR>]], kopts)
  api.nvim_set_keymap("n", "gd", [[:Lspsaga preview_definition<CR>]], kopts)
  api.nvim_set_keymap("n", "gp", [[:Lspsaga show_line_diagnostics<CR>]], kopts)
  api.nvim_set_keymap("n", "]e", [[:Lspsaga diagnostic_jump_next<CR>]], kopts)
  api.nvim_set_keymap("n", "[e", [[:Lspsaga diagnostic_jump_prev<CR>]], kopts)
  api.nvim_set_keymap("n", "<A-d>", [[:Lspsaga open_floaterm<CR>]], kopts)
  api.nvim_set_keymap("t", "<A-d>", [[<C-\><C-n>:Lspsaga close_floaterm<CR>]], kopts)
  api.nvim_set_keymap("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], kopts)
  api.nvim_set_keymap("n", "gD", [[<cmd>lua vim.lsp.buf.declaration()<CR>]], kopts)

  api.nvim_exec(
    [[
   augroup user_plugin_lspconfig
   autocmd! * <buffer>
   augroup END
   ]],
    true
  )

  local ft_auto_format = {
    "ruby",
  }

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if vim.tbl_contains(ft_auto_format, filetype) then
    -- ↓ available format only filetype
    vim.api.nvim_set_keymap("n", "gF", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], kopts)

    -- ↓ format on save
    -- vim.cmd([[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
  end
end

local custom_on_init = function()
  print("Language Server Protocol started!")
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true

local textlint = {
  lintCommand = "textlint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m [%trror/%r]" },
}

lspconfig.efm.setup({
  on_attach = custom_on_attach,
  init_options = {
    rename = false,
    hover = true,
    documentFormatting = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  filetypes = {
    "markdown",
  },
  settings = {
    -- efm work on anyway: https://github.com/mattn/efm-langserver/issues/125
    rootMarkers = { vim.loop.cwd() },
    languages = {
      markdown = { textlint },
    },
  },
})

local sumneko_root = vim.fn.stdpath("config") .. "/lua/modules/lua-language-server"
lspconfig.sumneko_lua.setup({
  cmd = {
    sumneko_root .. "/bin/macOS/lua-language-server",
    "-E",
    sumneko_root .. "/main.lua",
  },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        preloadFileSize = 400,
      },
    },
  },
})

lspconfig.solargraph.setup({
  cmd = { "solargraph", "stdio" },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      completion = true,
      definitions = true,
      diagnostics = true,
      folding = true,
      formatting = true,
      hover = true,
      references = true,
      symbols = true,
    },
  },
})
