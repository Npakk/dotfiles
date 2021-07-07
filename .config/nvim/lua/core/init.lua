-- Enhansement autocommand
vim.cmd('augroup MyAutoCmd')
vim.cmd('autocmd!')
vim.cmd('augroup END')

-- Python2 provider
if vim.fn.executable(vim.env.PYENV_ROOT .. '/versions/py2/bin/python') == 1 then
  vim.g.python_host_prog = vim.env.PYENV_ROOT .. '/versions/py2/bin/python'
else
  vim.g.loaded_python_provider = 0
end

-- Python3 provider
if vim.fn.executable(vim.env.PYENV_ROOT .. '/versions/py3/bin/python') == 1 then
  vim.g.python3_host_prog = vim.env.PYENV_ROOT .. '/versions/py3/bin/python'
else
  vim.g.loaded_python3_provider = 0
end

-- Ruby provider
if vim.fn.executable(vim.env.RBENV_ROOT .. '/versions/3.0.1/bin/neovim-ruby-host') == 1 then
  vim.g.ruby_host_prog = vim.env.RBENV_ROOT .. '/versions/3.0.1/bin/neovim-ruby-host'
else
  vim.g.loaded_ruby_provider = 0
end

-- Node.js provider
if vim.fn.executable('/usr/local/bin/neovim-node-host') == 1 then
  vim.g.node_host_prog = '/usr/local/bin/neovim-node-host'
else
  vim.g.loaded_node_provider = 0
end

-- Perl provider
vim.g.loaded_perl_provider = 0

vim.cmd('filetype off')
vim.cmd('syntax off')

require 'core.options'
require 'core.mappings'
require 'core.packer'
require 'core.appearance'

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')