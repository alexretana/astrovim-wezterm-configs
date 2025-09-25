-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Tab bar transparency with borders
        TabLine = { bg = "NONE" }, -- Make tabline background transparent
        TabLineFill = { bg = "NONE" }, -- Make tabline fill transparent
        TabLineSel = {
          bg = "NONE",
          fg = "#ffffff",
          bold = true,
          sp = "#61afef", -- Border color
          underline = true
        },
        -- Heirline tabline components
        HeirlineTabline = { bg = "NONE" },
        HeirlineTablineBufferActive = {
          bg = "NONE",
          fg = "#61afef",
          bold = true,
          underline = true
        },
        HeirlineTablineBufferInactive = {
          bg = "NONE",
          fg = "#888888",
          underline = true
        },
        HeirlineTablineTabActive = {
          bg = "NONE",
          fg = "#61afef",
          bold = true,
          underline = true
        },
        HeirlineTablineTabInactive = {
          bg = "NONE",
          fg = "#888888",
          underline = true
        },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Tab bar transparency with borders for astrodark theme
        TabLine = { bg = "NONE" },
        TabLineFill = { bg = "NONE" },
        TabLineSel = {
          bg = "NONE",
          fg = "#d4d4aa",
          bold = true,
          sp = "#50a7e1", -- Blue border for active tab
          underline = true
        },
        HeirlineTabline = { bg = "NONE" },
        HeirlineTablineBufferActive = {
          bg = "NONE",
          fg = "#50a7e1",
          bold = true,
          underline = true
        },
        HeirlineTablineBufferInactive = {
          bg = "NONE",
          fg = "#6c6f85",
          underline = true
        },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
