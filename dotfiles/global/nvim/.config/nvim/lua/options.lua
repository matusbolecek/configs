require "nvchad.options"

vim.opt.shell = "zsh"

local o = vim.o
o.cursorlineopt = 'both' -- to enable cursorline!
o.relativenumber = true

vim.g.python3_host_prog = vim.fn.expand("~/.nvim-venv/bin/python")
vim.g.loaded_python3_provider = nil
