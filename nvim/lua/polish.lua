-- File activated - clipboard configuration applied

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Fix clipboard configuration for Windows using win32yank
vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}

-- Don't automatically use system clipboard for all operations
-- This keeps yy normal, but allows "+y to work
vim.opt.clipboard = ""
