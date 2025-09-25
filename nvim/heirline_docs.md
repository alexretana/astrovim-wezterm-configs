================
CODE SNIPPETS
================
TITLE: Setup heirline.nvim configuration
DESCRIPTION: This Lua code demonstrates the basic setup for heirline.nvim. It shows how to call the `setup` function with configuration options for `statusline`, `winbar`, `tabline`, and `statuscolumn`. Users need to refer to the documentation to learn how to define the content for these sections.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/README.md#_snippet_1

LANGUAGE: lua
CODE:
```
require("heirline").setup({
    statusline = {...},
    winbar = {...},
    tabline = {...},
    statuscolumn = {...},
})
```

--------------------------------

TITLE: Setup Heirline with Statusline and Winbar Configurations (Lua)
DESCRIPTION: Demonstrates how to initialize heirline.nvim with custom configurations for the statusline, winbar, tabline, and statuscolumn. It includes an example of a callback function to conditionally disable the winbar based on buffer properties.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_60

LANGUAGE: lua
CODE:
```
require("heirline").setup({
    statusline = {...},
    winbar = {...},
    tabline = {...},
    statuscolumn = {...},
    opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
            return conditions.buffer_matches({
                buftype = { "nofile", "prompt", "help", "quickfix" },
                filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
        end,
    },
})
```

--------------------------------

TITLE: Install heirline.nvim with Packer
DESCRIPTION: This code snippet demonstrates how to install the heirline.nvim plugin using the Packer plugin manager for Neovim. It includes an optional configuration to lazy-load the plugin on `UiEnter` to ensure all dependencies and colorschemes are loaded before setup.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/README.md#_snippet_0

LANGUAGE: lua
CODE:
```
use({
    "rebelot/heirline.nvim",
    -- You can optionally lazy-load heirline on UiEnter
    -- to make sure all required plugins and colorschemes are loaded before setup
    -- event = "UiEnter",
    config = function()
        require("heirline").setup({...})
    end
})
```

--------------------------------

TITLE: Heirline.nvim Initial Setup with Conditions and Utilities
DESCRIPTION: This Lua code snippet shows the basic initialization for Heirline.nvim. It requires the `conditions` and `utils` modules, which are essential for creating dynamic statusline components and accessing helper functions. This setup is typically placed in a plugin configuration file.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_20

LANGUAGE: lua
CODE:
```
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
```

--------------------------------

TITLE: Heirline.nvim Setup and Component Definition (Lua)
DESCRIPTION: Demonstrates the basic structure for defining statuslines, winbars, and tablines using nested Lua tables as blueprints for Heirline.nvim's StatusLine objects. It shows how to pass these configurations to the `setup` function, along with optional configuration parameters.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_0

LANGUAGE: lua
CODE:
```
local StatusLine = {
    {"..."}, {"..."}, {"...", {"..."}, {"..."}, {"...", {"..."}, {"...", {"..."}}}
}

local WinBar = {{...}, {{...}, {...}}}

local TabLine = {{...}, {...}, {...}}

-- the winbar parameter is optional!
require("heirline").setup({
    statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    statuscolumn = StatusColumn
    opts = {...} -- other config parameters, see below
})
```

LANGUAGE: lua
CODE:
```
local Component1 = { ... }

local Sub1 = { ... }

local Component2 = { ... }

local statusline = {
    ...,
    {Component1, Sub1},
    Component2,
}
```

--------------------------------

TITLE: Heirline Setup Functions
DESCRIPTION: Functions to initialize and configure the heirline statusline, winbar, and tabline. Includes options for loading and clearing color aliases, and resetting highlight caches.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_14

LANGUAGE: lua
CODE:
```
require('heirline').setup(statusline, winbar?, tabline?)
require('heirline').load_colors(colors)
require('heirline').clear_colors()
require('heirline').reset_highlights()
```

--------------------------------

TITLE: Example of Nested Flexible Components in Heirline.nvim
DESCRIPTION: Demonstrates complex nesting of flexible components with varying priorities to illustrate Heirline.nvim's adaptive behavior. This example shows how components expand and contract based on their defined priorities and nesting levels.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_48

LANGUAGE: lua
CODE:
```
local a = { provider = string.rep("A", 40) }
local b = { provider = string.rep("B", 30) }
local c = { provider = string.rep("C", 20) }
local d = { provider = string.rep("D", 10) }
local e = { provider = string.rep("E", 8) }
local f = { provider = string.rep("F", 4) }

local nest_madness = {
    {
        flexible = 1, -- first root, with two levels of nesting, for a total of #3 levels
        a,
        {
            flexible = true, -- nested components priority is ignored!
            b,
            {
                flexible = true,
                c,
                d
            },
            e
        },
        f
    },
    {
        provider = "%="
    },
    {
        flexible = 4, -- second root, if we want it to have a higher priority, priority should be at least 1 + 3 = 4
        a,
        {
            flexible = true,
            b,
            {
                flexible = true,
                c,
                d
            },
            e
        },
        f
    },
}
require("heirline").setup(nest_madness)
```

--------------------------------

TITLE: Setup Heirline Statusline Configuration in Lua
DESCRIPTION: Initializes the Heirline.nvim plugin with the defined `StatusLines` configuration in Lua. This is the final step to apply the custom statusline setup.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_58

LANGUAGE: lua
CODE:
```
require("heirline").setup({ statusline = StatusLines })
```

--------------------------------

TITLE: Setup Heirline Statusline and Tabline (Lua)
DESCRIPTION: Configures the heirline.nvim plugin by setting the statusline, winbar, and tabline components. It also includes Neovim options to display the tabline and a filetype autocommand to manage buffer listing.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_77

LANGUAGE: lua
CODE:
```
local TabLine = { TabLineOffset, BufferLine, TabPages }

require("heirline").setup({
    statusline = StatusLines,
    winbar = WinBars,
    tabline = TabLine
})

-- Yep, with heirline we're driving manual!
vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

```

--------------------------------

TITLE: Define Diagnostics Click Callback in Heirline.nvim
DESCRIPTION: Configures an `on_click` callback for the Diagnostics component in Heirline.nvim. When clicked, it opens the 'trouble' plugin to display document diagnostics or sets the quickfix list. This example demonstrates integrating external plugins with Heirline's click functionality.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_65

LANGUAGE: lua
CODE:
```
local Diagnostics = {

    on_click = {
        callback = function()
            require("trouble").toggle({ mode = "document_diagnostics" })
            -- or
            -- vim.diagnostic.setqflist()
        end,
        name = "heirline_diagnostics",
    },
    ...
}
```

--------------------------------

TITLE: Configure Heirline.nvim Options with Custom Colors
DESCRIPTION: This Lua code snippet demonstrates configuring Heirline.nvim by passing a table of custom color aliases to the `opts.colors` option during setup. This allows for centralized color management within the Heirline configuration, enabling the use of defined color names in statusline components.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_19

LANGUAGE: lua
CODE:
```
local utils = require("heirline.utils")

local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffDeleted").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
}

require("heirline").setup({
    ...,
    opts = {
        ...,
        colors = colors,
    }
})
```

--------------------------------

TITLE: Custom Winbar Styles for Terminals and Regular Files (Lua)
DESCRIPTION: Provides examples of defining different winbar styles based on the current buffer type. It includes a specific style for terminal buffers and another for regular files, utilizing utility functions for visual enhancements like surrounding characters and highlighting.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_61

LANGUAGE: lua
CODE:
```
local WinBars = {
    fallthrough = false,
    {
        condition = function()
            return conditions.buffer_matches({ buftype = { "terminal" } })
        end,
        utils.surround({ "", "" }, "dark_red", {
            FileType,
            Space,
            TerminalName,
        }),
    },
    {
        condition = function()
            return not conditions.is_active()
        end,
        utils.surround({ "", "" }, "bright_bg", { hl = { fg = "gray", force = true }, FileNameBlock }),
    },
    -- A winbar for regular files
    utils.surround({ "", "" }, "bright_bg", FileNameBlock),
}

require("heirline").setup({ statusline = StatusLines, winbar = WinBars })
```

--------------------------------

TITLE: Implement Close Button Click Callback in Heirline.nvim
DESCRIPTION: Provides an example of a close button component for Heirline.nvim's winbar. It uses `minwid` to get the window ID and defines an `on_click` callback that closes the associated window. The `condition` ensures it only appears when the buffer is not modified.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_69

LANGUAGE: lua
CODE:
```
local CloseButton = {
    condition = function(self)
        return not vim.bo.modified
    end,
    -- a small performance improvement:
    -- re register the component callback only on layout/buffer changes.
    update = {'WinNew', 'WinClosed', 'BufEnter'},
    { provider = " " },
    {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
            minwid = function()
                return vim.api.nvim_get_current_win()
            end,
            callback = function(_, minwid)
                vim.api.nvim_win_close(minwid, true)
            end,
            name = "heirline_winbar_close_button"
        },
    },
}

-- Use it anywhere!
local WinBarFileName = utils.surround({ "", "" }, "bright_bg", {
    hl = function()
        if not conditions.is_active() then
            return { fg = "gray", force = true }
        end
    end,
    FileNameBlock,
    Space,
    CloseButton,
})
```

--------------------------------

TITLE: StatusLine Constructor and Evaluation Methods in Heirline.nvim
DESCRIPTION: This snippet details the core methods for creating and evaluating StatusLine objects in Heirline.nvim. The `new` method instantiates a StatusLine object recursively, while `eval` recursively evaluates the statusline components, executing various functions like `condition`, `init`, `hl`, and `provider`. Other methods like `nonlocal`, `local_`, `broadcast`, `get`, `set_win_attr`, `get_win_attr`, and `traverse` provide ways to interact with and manage statusline components.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_13

LANGUAGE: lua
CODE:
```
new(self, child)
eval(self)
nonlocal(self, attr)
local_(self, attr)
broadcast(self, func)
get(self, id)
set_win_attr(self, attr, default)
get_win_attr(self, attr, default)
traverse()
```

--------------------------------

TITLE: Display Lazy Plugin Manager Updates with Heirline.nvim
DESCRIPTION: This snippet configures Heirline.nvim to display the number of pending updates for plugins managed by the Lazy.nvim plugin manager. It uses `lazy.status.has_updates` for the condition and `lazy.status.updates` to get the count. It also includes an `on_click` callback to trigger a plugin update when the component is clicked.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/__wiki__/Exotic-recipes.md#_snippet_2

LANGUAGE: lua
CODE:
```
local Lazy = {
    condition = require("lazy.status").has_updates,
    update = { "User", pattern = "LazyUpdate" },
    provider = function() return "  " .. require("lazy.status").updates() .. " " end,
    on_click = {
      callback = function() require("lazy").update() end,
      name = "update_plugins",
    },
    hl = { fg = "gray" },
  }

```

--------------------------------

TITLE: Integrate External Colorscheme Colors with Heirline.nvim
DESCRIPTION: This Lua code snippet shows how to integrate colors from an external Neovim colorscheme, specifically Kanagawa, into Heirline.nvim. It first requires the colors setup from the colorscheme and then uses `require('heirline').load_colors()` to make these colors available as aliases within Heirline's configuration.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_18

LANGUAGE: lua
CODE:
```
local colors = require'kanagawa.colors'.setup() -- wink

require("heirline").load_colors(colors)
```

--------------------------------

TITLE: Dynamic Theming with Color Scheme Changes (Lua)
DESCRIPTION: Provides a Lua function `setup_colors` to dynamically fetch highlight group colors for theming heirline.nvim components. It sets up an autocommand that re-evaluates these colors whenever the ColorScheme event is triggered, ensuring the status line updates with the color scheme.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_78

LANGUAGE: lua
CODE:
```
local function setup_colors() 
    return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("diffDeleted").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffChanged").fg,
    }
end

-- require("heirline").load_colors(setup_colors)
-- or pass it to config.opts.colors

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function() 
        utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})


```

--------------------------------

TITLE: Define LSPActive Click Callback in Heirline.nvim
DESCRIPTION: Configures an `on_click` callback for the LSPActive component in Heirline.nvim. This callback uses `vim.defer_fn` to asynchronously open the `LspInfo` window, providing a non-blocking way to access Language Server Protocol information.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_67

LANGUAGE: lua
CODE:
```
local LSPActive = {
    on_click = {
        callback = function()
            vim.defer_fn(function()
                vim.cmd("LspInfo")
            end, 100)
        end,
        name = "heirline_LSP",
    },
    ...
}
```

--------------------------------

TITLE: Integrate Dropbar.nvim with Heirline.nvim
DESCRIPTION: This component integrates Heirline.nvim with dropbar.nvim to display navigation information. It fetches data from dropbar, processes components (icons and names), and sets up click callbacks for navigation. The snippet dynamically builds the Heirline component based on the data provided by dropbar.nvim.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/__wiki__/Exotic-recipes.md#_snippet_3

LANGUAGE: lua
CODE:
```
local Dropbar = {
  condition = function(self)
    self.data = vim.tbl_get(dropbar.bars or {}, vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
    return self.data
  end,
  static = { dropbar_on_click_string = 'v:lua.dropbar.callbacks.buf%s.win%s.fn%s' },
  init = function(self)
    local components = self.data.components
    local children = {}
    for i, c in ipairs(components) do
      local child = {
        {
          hl = c.icon_hl,
          provider = c.icon:gsub('%%', '%%%%'),
        },
        {
          hl = c.name_hl,
          provider = c.name:gsub('%%', '%%%%'),
        },
        on_click = {
          callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i),
          name = 'heirline_dropbar',
        },
      }
      if i < #components then
        local sep = self.data.separator
        table.insert(child, {
          provider = sep.icon,
          hl = sep.icon_hl,
          on_click = {
              callback = self.dropbar_on_click_string:format(self.data.buf, self.data.win, i + 1),
          },
        })
      end
      table.insert(children, child)
    end
    self.child = self:new(children, 1)
  end,
  provider = function(self) return self.child:eval() end,
}

```

--------------------------------

TITLE: Heirline Utility Functions
DESCRIPTION: Helper functions for manipulating components, managing highlights, and creating complex UI elements like bufferlines and tablists. These functions simplify the creation of dynamic and visually appealing statuslines.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_16

LANGUAGE: lua
CODE:
```
require('heirline.utils').get_highlight(hl_name)
require('heirline.utils').on_colorscheme(colors?)
require('heirline.utils').clone(component[, with])
require('heirline.utils').surround(delimiters, color, component)
require('heirline.utils').insert(parent, ...)
require('heirline.utils').make_buflist(buffer_component, left_trunc?, right_trunc?, buf_func?, buf_cache?)
require('heirline.utils').make_tablist(tab_component)
require('heirline.utils').count_chars(str)
```

--------------------------------

TITLE: Debugger Action Click Callbacks in Heirline.nvim
DESCRIPTION: Illustrates how to implement clickable buttons for debugger actions (step-into, step-out, step-over, run-last, terminate) in Heirline.nvim. Each button has an `on_click` callback that calls the corresponding `dap` function. This enables quick debugger control directly from the statusline.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_70

LANGUAGE: lua
CODE:
```
-- Note that we add spaces separately, so that only the icon characters will be clickable
local DAPMessages = {
    condition = function()
        local session = require("dap").session()
        return session ~= nil
    end,
    provider = function()
        return " " .. require("dap").status() .. " "
    end,
    hl = "Debug",
    {
        provider = "",
        on_click = {
            callback = function()
                require("dap").step_into()
            end,
            name = "heirline_dap_step_into",
        },
    },
    { provider = " " },
    {
        provider = "",
        on_click = {
            callback = function()
                require("dap").step_out()
            end,
            name = "heirline_dap_step_out",
        },
    },
    { provider = " " },
    {
        provider = " ",
        on_click = {
            callback = function()
                require("dap").step_over()
            end,
            name = "heirline_dap_step_over",
        },
    },
    { provider = " " },
    {
        provider = "ﰇ",
        on_click = {
            callback = function()
                require("dap").run_last()
            end,
            name = "heirline_dap_run_last",
        },
    },
    { provider = " " },
    {
        provider = "",
        on_click = {
            callback = function()
                require("dap").terminate()
                require("dapui").close({})
            end,
            name = "heirline_dap_close",
        },
    },
    { provider = " " },
    -- icons:       ﰇ  
}
```

--------------------------------

TITLE: Component Initialization with 'init' in Heirline.nvim
DESCRIPTION: The 'init' function is executed when a component is evaluated. It can modify the component's state via the 'self' parameter, allowing for computation of values shared among child components.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_10

LANGUAGE: lua
CODE:
```
init = function(self)
  -- Modify self.attribute
end
```

--------------------------------

TITLE: Flexible WorkDir Component for Heirline.nvim
DESCRIPTION: A flexible Heirline.nvim component that displays the current working directory. It dynamically switches between the full path and a shortened path based on available space, using different priorities for expansion and contraction.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_49

LANGUAGE: lua
CODE:
```
local WorkDir = {
    init = function(self)
        self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
        local cwd = vim.fn.getcwd(0)
        self.cwd = vim.fn.fnamemodify(cwd, ":~")
    end,
    hl = { fg = "blue", bold = true },

    flexible = 1,

    {
        -- evaluates to the full-lenth path
        provider = function(self)
            local trail = self.cwd:sub(-1) == "/" and "" or "/"
            return self.icon .. self.cwd .. trail .. " "
        end,
    },
    {
        -- evaluates to the shortened path
        provider = function(self)
            local cwd = vim.fn.pathshorten(self.cwd)
            local trail = self.cwd:sub(-1) == "/" and "" or "/"
            return self.icon .. cwd .. trail .. " "
        end,
    },
    {
        -- evaluates to "", hiding the component
        provider = "",
    },
}
```

--------------------------------

TITLE: Advanced nvim-navic Integration with Clickable Elements (Lua)
DESCRIPTION: This advanced Lua configuration for `nvim-navic` in heirline.nvim enables clickable elements for code structure navigation. It includes helper functions for encoding/decoding cursor positions, defining highlight mappings for different symbol types, and dynamically creating children for each scope level. Clicking an element will jump the cursor to that location.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_33

LANGUAGE: lua
CODE:
```
-- Full nerd (with icon colors and clickable elements)!
-- works in multi window, but does not support flexible components (yet ...)
local Navic = {
    condition = function() return require("nvim-navic").is_available() end,
    static = {
        -- create a type highlight map
        type_hl = {
            File = "Directory",
            Module = "@include",
            Namespace = "@namespace",
            Package = "@include",
            Class = "@structure",
            Method = "@method",
            Property = "@property",
            Field = "@field",
            Constructor = "@constructor",
            Enum = "@field",
            Interface = "@type",
            Function = "@function",
            Variable = "@variable",
            Constant = "@constant",
            String = "@string",
            Number = "@number",
            Boolean = "@boolean",
            Array = "@field",
            Object = "@type",
            Key = "@keyword",
            Null = "@comment",
            EnumMember = "@field",
            Struct = "@structure",
            Event = "@keyword",
            Operator = "@operator",
            TypeParameter = "@type",
        },
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
            return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(c)
            local line = bit.rshift(c, 16)
            local col = bit.band(bit.rshift(c, 6), 1023)
            local winnr = bit.band(c, 63)
            return line, col, winnr
        end
    },
    init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        -- create a child for each level
        for i, d in ipairs(data) do
            -- encode line and column numbers into a single integer
            local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
            local child = {
                {
                    provider = d.icon,
                    hl = self.type_hl[d.type],
                },
                {
                    -- escape `%`s (elixir) and buggy default separators
                    provider = d.name:gsub("%", "%%%%"):gsub("%s*->%s*", ''),
                    -- highlight icon only or location name as well
                    -- hl = self.type_hl[d.type],

                    on_click = {
                        -- pass the encoded position through minwid
                        minwid = pos,
                        callback = function(_, minwid)
                            -- decode
                            local line, col, winnr = self.dec(minwid)
                            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {line, col})
                        end,
                        name = "heirline_navic",
                    },
                },
            }
            -- add a separator only if needed
            if #data > 1 and i < #data then
                table.insert(child, {
                    provider = " > ",
                    hl = { fg = 'bright_fg' },
                })
            end
            table.insert(children, child)
        end
    end
}

```

--------------------------------

TITLE: Handling Click Events for Components in Heirline.nvim
DESCRIPTION: The 'on_click' field allows defining actions to be performed when a component is clicked. It requires a 'callback' function or string, and can optionally specify a 'name' for the registered function and whether to 'update' the registration.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_3

LANGUAGE: lua
CODE:
```
{
  provider = "Clickable Component",
  on_click = {
    callback = function(self, minwid, nclicks, button, mods)
      print("Component clicked!")
    end,
    name = "my_clickable_component_callback",
    update = true -- Re-register callback on each evaluation
  }
}
```

LANGUAGE: lua
CODE:
```
{
  provider = "Another Clickable",
  on_click = {
    callback = "vim.cmd.redraw", -- Use a raw string for a vim command
    minwid = 10 -- Example of passing minwid
  }
}
```

--------------------------------

TITLE: Assemble and Configure Bufferline Components in Heirline.nvim (Lua)
DESCRIPTION: This Lua code assembles the previously defined bufferline components in heirline.nvim. It creates a `TablineFileNameBlock` that initializes the filename, sets highlighting based on buffer status, and defines click callbacks for buffer selection and deletion. It also includes a `TablineCloseButton` with an icon and click handler for closing buffers. Finally, it combines these into a `TablineBufferBlock` using `utils.surround` and creates the complete `BufferLine` using `utils.make_buflist`.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_72

LANGUAGE: lua
CODE:
```
-- Here the filename block finally comes together
local TablineFileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
        if self.is_active then
            return "TabLineSel"
        -- why not?
        -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
        --     return { fg = "gray" }
        else
            return "TabLine"
        end
    end,
    on_click = {
        callback = function(_, minwid, _, button)
            if (button == "m") then -- close on mouse middle click
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
    TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    { provider = " " },
    {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
            callback = function(_, minwid)
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                    vim.cmd.redrawtabline()
                end)
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback",
        },
    },
}

-- The final touch!
local TablineBufferBlock = utils.surround({ "", "" }, function(self)
    if self.is_active then
        return utils.get_highlight("TabLineSel").bg
    else
        return utils.get_highlight("TabLine").bg
    end
end, { TablineFileNameBlock, TablineCloseButton })

-- and here we go
local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
)
```

--------------------------------

TITLE: Define Git Click Callback in Heirline.nvim
DESCRIPTION: Sets up an `on_click` callback for a Git component in Heirline.nvim. This callback can be configured to trigger Fugitive commands (`G`) or open Lazygit using `vim.defer_fn` for asynchronous execution, useful when opening floating windows.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_66

LANGUAGE: lua
CODE:
```
local Git = {
    on_click = {
        callback = function()
            -- If you want to use Fugitive:
            -- vim.cmd("G")

            -- If you prefer Lazygit
            -- use vim.defer_fn() if the callback requires
            -- opening of a floating window
            -- (this also applies to telescope)
            vim.defer_fn(function()
                vim.cmd("Lazygit")
            end, 100)
        end,
        name = "heirline_git",
    },
    ...
}
```

--------------------------------

TITLE: FileFormat Component for Heirline.nvim (Lua)
DESCRIPTION: Displays the current buffer's file format (e.g., 'UNIX', 'DOS') if it is not the default 'unix'. It uses the 'fileformat' buffer-local option.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_25

LANGUAGE: lua
CODE:
```
local FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and fmt:upper()
    end
}

```

--------------------------------

TITLE: Flexible Navic Component for Heirline.nvim
DESCRIPTION: A simple flexible component for Heirline.nvim that hides the Navic information when space is constrained. It prioritizes showing the Navic details but will render an empty string if necessary, effectively making it disappear.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_51

LANGUAGE: lua
CODE:
```
local Navic = { flexible = 3, Navic, { provider = "" } }
```

--------------------------------

TITLE: Hierarchical Statusline Configuration with Conditions (Lua)
DESCRIPTION: Defines a structured statusline configuration using a genealogical tree approach. It prioritizes matching buffer properties like buftype, filetype, and bufname to select specific statusline components. It also includes logic to differentiate between active and inactive windows.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_59

LANGUAGE: lua
CODE:
```
local FelineStyle = {

    -- stop at child where buftype/filetype/bufname matches
    fallthrough = false,

    {   -- Identify the buftype/filetype/bufname first
        condtion = function()
            return conditions.buffer_matches({...})
        end,

        -- Evaluate only the "active" or "inactive" child
        fallthrough = false,

        {   -- If it's the current window, display some components
            condition = conditions.is_active
            {...} --
        },
        {   -- Otherwise, display some other components
            {...} --
        }
    },
    {   -- this block can be exactly as the one above for a different kind of
        -- buffer
        ...
    }
}
```

--------------------------------

TITLE: FileNameBlock Component for Heirline.nvim
DESCRIPTION: Defines the FileNameBlock component which aggregates file icon, name, flags, and a truncation marker. It initializes with the current buffer's filename and dynamically provides content for each part. Dependencies include nvim-web-devicons for icons and utility functions for component manipulation.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_22

LANGUAGE: lua
CODE:
```
local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
    },
}

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            return { fg = "cyan", bold = true, force=true }
        end
    end,
}

FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName),
    FileFlags,
    { provider = '%<'} 
)

```

--------------------------------

TITLE: Configure and Use Heirline.nvim Diagnostics Component
DESCRIPTION: This Lua code defines the `Diagnostics` component for heirline.nvim. It fetches diagnostic counts (errors, warnings, info, hints) and their corresponding icons, then displays them with customizable highlighting. The component updates on diagnostic changes or buffer entry.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_34

LANGUAGE: lua
CODE:
```
local Diagnostics = {

    condition = conditions.has_diagnostics,
    -- Example of defining custom LSP diagnostic icons, you can copypaste in your config:
    --vim.diagnostic.config({
    --  signs = {
    --    text = {
    --      [vim.diagnostic.severity.ERROR] = '',
    --      [vim.diagnostic.severity.WARN] = '',
    --      [vim.diagnostic.severity.INFO] = '󰋇',
    --      [vim.diagnostic.severity.HINT] = '󰌵',
    --    },
    --  },
    --})
    -- Fetching custom diagnostic icons
    error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR],
    warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN],
    info_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO],
    hint_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT],

    -- If you defined custom LSP diagnostics with vim.fn.sign_define(), use this instead
    -- Note defining custom LSP diagnostic this way its deprecated, though
    --static = {
    --    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    --    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    --    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    --    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    --},

    init = function(self) {
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = "![",
    },
    {
        provider = function(self) {
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        },
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self) {
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        },
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self) {
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        },
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self) {
            return self.hints > 0 and (self.hint_icon .. self.hints)
        },
        hl = { fg = "diag_hint" },
    },
    {
        provider = "]",
    },
}

```

--------------------------------

TITLE: Implement Tabline Buffer Picker in Heirline.nvim
DESCRIPTION: Implements a buffer picker for heirline.nvim triggered by a keymap. It assigns labels based on buffer names and allows navigation to a buffer by pressing its label key. The picker is displayed conditionally and hidden after selection. Dependencies include the 'heirline' module and 'vim.api'.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_74

LANGUAGE: lua
CODE:
```
local TablinePicker = {
    condition = function(self)
        return self._show_picker
    end,
    init = function(self)
        local bufname = vim.api.nvim_buf_get_name(self.bufnr)
        bufname = vim.fn.fnamemodify(bufname, ":t")
        local label = bufname:sub(1, 1)
        local i = 2
        while self._picker_labels[label] do
            if i > #bufname then
                break
            end
            label = bufname:sub(i, i)
            i = i + 1
        end
        self._picker_labels[label] = self.bufnr
        self.label = label
    end,
    provider = function(self)
        return self.label
    end,
    hl = { fg = "red", bold = true },
}

vim.keymap.set("n", "gbp", function()
    local tabline = require("heirline").tabline
    local buflist = tabline._buflist[1]
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then
        vim.api.nvim_win_set_buf(0, bufnr)
    end
    buflist._show_picker = false
    vim.cmd.redrawtabline()
end)

```

--------------------------------

TITLE: Define Basic Statusline Components in Lua
DESCRIPTION: Defines simple `Align` and `Space` components using Lua, which are reusable building blocks for creating statuslines. These components help manage alignment and spacing within the statusline.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_52

LANGUAGE: lua
CODE:
```
local Align = { provider = "%=" }
local Space = { provider = " " }
```

--------------------------------

TITLE: FileSize Component for Heirline.nvim (Lua)
DESCRIPTION: Calculates and displays the human-readable size of the current file. It uses Vim's getfsize function and a helper array for size suffixes (b, k, M, G, etc.). Handles negative file sizes by defaulting to 0.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_26

LANGUAGE: lua
CODE:
```
local FileSize = {
    provider = function()
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize..suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
    end
}

```

--------------------------------

TITLE: Basic Component Provider in Heirline.nvim
DESCRIPTION: The 'provider' field is the most fundamental part of a component, specifying the text or data to be displayed. It can be a static string or number, or a function that dynamically generates the content.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_4

LANGUAGE: lua
CODE:
```
{
  provider = "Static Text Component"
}
```

LANGUAGE: lua
CODE:
```
{
  provider = function(self)
    return "Current buffer: " .. vim.fn.bufname() -- Dynamic provider using buffer name
  end
}
```

--------------------------------

TITLE: Flexible FileName Component for Heirline.nvim
DESCRIPTION: Configures a flexible component for Heirline.nvim to display the current file name. It offers two states: the full filename and a shortened version, prioritizing the full name and falling back to the shortened one when space is limited.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_50

LANGUAGE: lua
CODE:
```
local FileName = {
    init = function(self)
        self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
        if self.lfilename == "" then self.lfilename = "[No Name]" end
    end,
    hl = { fg = utils.get_highlight("Directory").fg },

    flexible = 2,

    {
        provider = function(self)
            return self.lfilename
        end,
    },
    {
        provider = function(self)
            return vim.fn.pathshorten(self.lfilename)
        end,
    },
}
```

--------------------------------

TITLE: Show Current Working Directory (Lua)
DESCRIPTION: This Lua snippet defines a Working Directory component for Heirline.nvim. It displays the global or local working directory, prepended with an icon indicating its scope ('l' for local, 'g' for global). It uses `vim.fn.getcwd` and `vim.fn.pathshorten` for path manipulation.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_40

LANGUAGE: lua
CODE:
```
local WorkDir = {
    provider = function() {
        local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~~")
        if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
        end
        local trail = cwd:sub(-1) == '/' and '' or "/"
        return icon .. cwd  .. trail
    end,
    hl = { fg = "blue", bold = true },
}

```

--------------------------------

TITLE: Flexible Components in Heirline.nvim
DESCRIPTION: The 'flexible' field designates a component as flexible, allowing it to adapt its size based on available space. Children must be ordered by decreasing length, and only the longest fitting child is rendered. Priority can be set as an integer or boolean.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_6

LANGUAGE: lua
CODE:
```
flexible = 10
-- or
flexible = true
```

--------------------------------

TITLE: Display LSP Progress Messages using lsp-status (Lua)
DESCRIPTION: This Lua snippet shows how to integrate the `lsp-status.nvim` plugin to display LSP progress messages within the heirline.nvim statusline. It utilizes the `lsp-status.status` function as the provider for the statusline component. This is a simple way to show ongoing LSP operations.

SOURCE: https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#_snippet_31

LANGUAGE: lua
CODE:
```
-- I personally use it only to display progress messages!
-- See lsp-status/README.md for configuration options.

-- Note: check "j-hui/fidget.nvim" for a nice statusline-free alternative.
local LSPMessages = {
    provider = require("lsp-status").status,
    hl = { fg = "gray" },
}

```