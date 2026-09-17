local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- Math snippets live in math.lua (shared with tex)
return {
  s({ trig = "mk", snippetType = "autosnippet" },
    fmta("$<>$", { i(1) })
  ),
  s({ trig = "dm", snippetType = "autosnippet", wordTrig = true },
    fmta("$$\n<>\n$$", { i(1) })
  ),
}
