require "nvchad.options"

-- add yours here!

vim.opt.shell = "zsh"

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

o.relativenumber = true
vim.g.loaded_python3_provider = nil

vim.g.python3_host_prog = vim.fn.expand("~/.nvim-venv/bin/python")

-- Ensure provider is enabled
vim.g.loaded_python3_provider = nil

-- Enable the remote plugin system
vim.g.loaded_remote_plugins = nil
vim.g.loaded_python3_provider = nil
