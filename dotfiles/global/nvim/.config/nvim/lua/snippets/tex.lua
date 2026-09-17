local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local in_mathzone = require("configs.mathzone").in_mathzone

-- Math snippets live in math.lua (shared with markdown)
return {
  s({ trig = "mk", snippetType = "autosnippet" },
    fmta("$<>$", { i(1) })
  ),
  s({ trig = "dm", snippetType = "autosnippet", wordTrig = true },
    fmta("\\[\n<>\n\\]", { i(1) })
  ),
  -- text-mode environments (math-mode beg is in math.lua)
  s({ trig = "beg", snippetType = "autosnippet" },
    fmta("\\begin{<>}\n<>\n\\end{<>}", { i(1), i(2), rep(1) }),
    { condition = function() return not in_mathzone() end }
  ),
}
