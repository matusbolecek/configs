local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- ── Math zone detection ───────────────────────────────────────────────────────
-- Counts $ delimiters to determine if cursor is inside inline or display math.
local function in_mathzone()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local line = lines[row]
  local before_cursor = line:sub(1, col)

  -- Inline math: odd number of $ before cursor on this line
  local _, inline_count = before_cursor:gsub("%$", "")
  if inline_count % 2 == 1 then return true end

  -- Display math: odd number of $$ blocks above cursor
  local display_count = 0
  for r = 1, row - 1 do
    local _, c = lines[r]:gsub("%$%$", "")
    display_count = display_count + c
  end
  local _, c = before_cursor:gsub("%$%$", "")
  display_count = display_count + c
  return display_count % 2 == 1
end

-- ── Visual selection helper ───────────────────────────────────────────────────
-- Returns selected text if in visual mode, otherwise an insert node.
local function visual_selection(_, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, t(parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {

  -- ── Math mode delimiters ──────────────────────────────────────────────────
  s({ trig = "mk", snippetType = "autosnippet" },
    fmta("$<>$", { i(1) })
  ),
  s({ trig = "dm", snippetType = "autosnippet", wordTrig = true },
    fmta("$$\n<>\n$$", { i(1) })
  ),
  s({ trig = "beg", snippetType = "autosnippet" },
    fmta("\\begin{<>}\n<>\n\\end{<>}", { i(1), i(2), rep(1) }),
    { condition = in_mathzone }
  ),
  s({ trig = "aug", snippetType = "autosnippet" },
    fmta("\\left[\\begin{array}{cc|c} <> \\end{array}\\right]", { i(1) }),
    { condition = in_mathzone }
  ),
  s({ trig = "tag", snippetType = "autosnippet" },
    fmta("\\tag{<>}", { i(1) }),
    { condition = in_mathzone }
  ),

  -- ── Greek letters ─────────────────────────────────────────────────────────
  s({ trig = "@a", snippetType = "autosnippet" }, { t("\\alpha") },   { condition = in_mathzone }),
  s({ trig = "@b", snippetType = "autosnippet" }, { t("\\beta") },    { condition = in_mathzone }),
  s({ trig = "@g", snippetType = "autosnippet" }, { t("\\gamma") },   { condition = in_mathzone }),
  s({ trig = "@G", snippetType = "autosnippet" }, { t("\\Gamma") },   { condition = in_mathzone }),
  s({ trig = "@d", snippetType = "autosnippet" }, { t("\\delta") },   { condition = in_mathzone }),
  s({ trig = "@D", snippetType = "autosnippet" }, { t("\\Delta") },   { condition = in_mathzone }),
  s({ trig = "@e", snippetType = "autosnippet" }, { t("\\epsilon") }, { condition = in_mathzone }),
  s({ trig = ":e", snippetType = "autosnippet" }, { t("\\varepsilon") }, { condition = in_mathzone }),
  s({ trig = "@z", snippetType = "autosnippet" }, { t("\\zeta") },    { condition = in_mathzone }),
  s({ trig = "@t", snippetType = "autosnippet" }, { t("\\theta") },   { condition = in_mathzone }),
  s({ trig = "@T", snippetType = "autosnippet" }, { t("\\Theta") },   { condition = in_mathzone }),
  s({ trig = ":t", snippetType = "autosnippet" }, { t("\\vartheta") }, { condition = in_mathzone }),
  s({ trig = "@i", snippetType = "autosnippet" }, { t("\\iota") },    { condition = in_mathzone }),
  s({ trig = "@k", snippetType = "autosnippet" }, { t("\\kappa") },   { condition = in_mathzone }),
  s({ trig = "@l", snippetType = "autosnippet" }, { t("\\lambda") },  { condition = in_mathzone }),
  s({ trig = "@L", snippetType = "autosnippet" }, { t("\\Lambda") },  { condition = in_mathzone }),
  s({ trig = "@s", snippetType = "autosnippet" }, { t("\\sigma") },   { condition = in_mathzone }),
  s({ trig = "@S", snippetType = "autosnippet" }, { t("\\Sigma") },   { condition = in_mathzone }),
  s({ trig = "@u", snippetType = "autosnippet" }, { t("\\upsilon") }, { condition = in_mathzone }),
  s({ trig = "@U", snippetType = "autosnippet" }, { t("\\Upsilon") }, { condition = in_mathzone }),
  s({ trig = "@o", snippetType = "autosnippet" }, { t("\\omega") },   { condition = in_mathzone }),
  s({ trig = "@O", snippetType = "autosnippet" }, { t("\\Omega") },   { condition = in_mathzone }),
  s({ trig = "ome", snippetType = "autosnippet" }, { t("\\omega") },  { condition = in_mathzone }),
  s({ trig = "Ome", snippetType = "autosnippet" }, { t("\\Omega") },  { condition = in_mathzone }),

  -- ── Text environment ──────────────────────────────────────────────────────
  s({ trig = "text", snippetType = "autosnippet" },
    fmta("\\text{<>}<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),

  -- ── Basic operations ──────────────────────────────────────────────────────
  s({ trig = "sr",   snippetType = "autosnippet" }, { t("^{2}") },    { condition = in_mathzone }),
  s({ trig = "cb",   snippetType = "autosnippet" }, { t("^{3}") },    { condition = in_mathzone }),
  s({ trig = "invs", snippetType = "autosnippet" }, { t("^{-1}") },   { condition = in_mathzone }),
  s({ trig = "conj", snippetType = "autosnippet" }, { t("^{*}") },    { condition = in_mathzone }),
  s({ trig = "Re",   snippetType = "autosnippet" }, { t("\\mathrm{Re}") }, { condition = in_mathzone }),
  s({ trig = "Im",   snippetType = "autosnippet" }, { t("\\mathrm{Im}") }, { condition = in_mathzone }),
  s({ trig = "rd", snippetType = "autosnippet" },
    fmta("^{<>}<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "sts", snippetType = "autosnippet" },
    fmta("_\\text{<>}", { i(1) }),
    { condition = in_mathzone }
  ),
  s({ trig = "sq", snippetType = "autosnippet" },
    fmta("\\sqrt{ <> }<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "//", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}<>", { i(1), i(2), i(3) }),
    { condition = in_mathzone }
  ),
  s({ trig = "ee", snippetType = "autosnippet" },
    fmta("e^{ <> }<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "bf", snippetType = "autosnippet" },
    fmta("\\mathbf{<>}", { i(1) }),
    { condition = in_mathzone }
  ),
  s({ trig = "rm", snippetType = "autosnippet" },
    fmta("\\mathrm{<>}<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),

  -- ── Regex: auto letter subscript ──────────────────────────────────────────
  s({ trig = "([%a])(%d)", regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip) return snip.captures[1] end),
      f(function(_, snip) return snip.captures[2] end),
    }),
    { condition = in_mathzone }
  ),
  s({ trig = "([%a])_(%d%d)", regTrig = true, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip) return snip.captures[1] end),
      f(function(_, snip) return snip.captures[2] end),
    }),
    { condition = in_mathzone }
  ),

  -- ── exp / log / ln / det auto-backslash ───────────────────────────────────
  s({ trig = "([^\\\\])(exp|log|ln)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return snip.captures[1] .. "\\" .. snip.captures[2] end),
    { condition = in_mathzone }
  ),
  s({ trig = "([^\\\\])(det)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return snip.captures[1] .. "\\det" end),
    { condition = in_mathzone }
  ),

  -- ── Linear algebra ────────────────────────────────────────────────────────
  s({ trig = "trace", snippetType = "autosnippet" }, { t("\\mathrm{Tr}") }, { condition = in_mathzone }),

  -- ── Decorators (regex: letter + keyword) ─────────────────────────────────
  s({ trig = "([a-zA-Z])hat",   regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\hat{"       .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])bar",   regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\bar{"       .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])ddot",  regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\ddot{"      .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])dot",   regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\dot{"       .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])tilde", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\tilde{"     .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])und",   regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\underline{" .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "([a-zA-Z])vec",   regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\vec{"       .. snip.captures[1] .. "}" end),
    { condition = in_mathzone }
  ),

  -- Decorators (standalone, with insert node)
  s({ trig = "hat",   snippetType = "autosnippet" }, fmta("\\hat{<>}<>",       { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "bar",   snippetType = "autosnippet" }, fmta("\\bar{<>}<>",       { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "ddot",  snippetType = "autosnippet" }, fmta("\\ddot{<>}<>",      { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "dot",   snippetType = "autosnippet" }, fmta("\\dot{<>}<>",       { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "cdot",  snippetType = "autosnippet" }, { t("\\cdot") },                           { condition = in_mathzone }),
  s({ trig = "tilde", snippetType = "autosnippet" }, fmta("\\tilde{<>}<>",     { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "und",   snippetType = "autosnippet" }, fmta("\\underline{<>}<>", { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "vec",   snippetType = "autosnippet" }, fmta("\\vec{<>}<>",       { i(1), i(2) }), { condition = in_mathzone }),

  -- Decorated-letter subscripts
  s({ trig = "\\hat{([%a])}(%d)",    regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\hat{"    .. snip.captures[1] .. "}_{" .. snip.captures[2] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "\\vec{([%a])}(%d)",    regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\vec{"    .. snip.captures[1] .. "}_{" .. snip.captures[2] .. "}" end),
    { condition = in_mathzone }
  ),
  s({ trig = "\\mathbf{([%a])}(%d)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return "\\mathbf{" .. snip.captures[1] .. "}_{" .. snip.captures[2] .. "}" end),
    { condition = in_mathzone }
  ),

  -- ── Common subscript shorthands ───────────────────────────────────────────
  s({ trig = "xnn", snippetType = "autosnippet" }, { t("x_{n}") },   { condition = in_mathzone }),
  s({ trig = "xii", snippetType = "autosnippet" }, { t("x_{i}") },   { condition = in_mathzone }),
  s({ trig = "xjj", snippetType = "autosnippet" }, { t("x_{j}") },   { condition = in_mathzone }),
  s({ trig = "xp1", snippetType = "autosnippet" }, { t("x_{n+1}") }, { condition = in_mathzone }),
  s({ trig = "ynn", snippetType = "autosnippet" }, { t("y_{n}") },   { condition = in_mathzone }),
  s({ trig = "yii", snippetType = "autosnippet" }, { t("y_{i}") },   { condition = in_mathzone }),
  s({ trig = "yjj", snippetType = "autosnippet" }, { t("y_{j}") },   { condition = in_mathzone }),

  -- ── Symbols ───────────────────────────────────────────────────────────────
  s({ trig = "ooo",  snippetType = "autosnippet" }, { t("\\infty") },    { condition = in_mathzone }),
  s({ trig = "sum",  snippetType = "autosnippet" }, { t("\\sum") },      { condition = in_mathzone }),
  s({ trig = "prod", snippetType = "autosnippet" }, { t("\\prod") },     { condition = in_mathzone }),
  s({ trig = "nabl", snippetType = "autosnippet" }, { t("\\nabla") },    { condition = in_mathzone }),
  s({ trig = "del",  snippetType = "autosnippet" }, { t("\\nabla") },    { condition = in_mathzone }),
  s({ trig = "xx",   snippetType = "autosnippet" }, { t("\\times") },    { condition = in_mathzone }),
  s({ trig = "**",   snippetType = "autosnippet" }, { t("\\cdot") },     { condition = in_mathzone }),
  s({ trig = "para", snippetType = "autosnippet" }, { t("\\parallel") }, { condition = in_mathzone }),
  s({ trig = "...",  snippetType = "autosnippet" }, { t("\\dots") },     { condition = in_mathzone }),
  s({ trig = "+-",   snippetType = "autosnippet" }, { t("\\pm") },       { condition = in_mathzone }),
  s({ trig = "-+",   snippetType = "autosnippet" }, { t("\\mp") },       { condition = in_mathzone }),

  s({ trig = "lim", snippetType = "autosnippet" },
    fmta("\\lim_{ <> \\to <> } <>", { i(1, "n"), i(2, "\\infty"), i(3) }),
    { condition = in_mathzone }
  ),

  -- Expand \sum and \prod with limits (manual trigger, not auto)
  s({ trig = "\\sum" },
    fmta("\\sum_{<>=<>}^{<>} <>", { i(1, "i"), i(2, "1"), i(3, "N"), i(4) }),
    { condition = in_mathzone }
  ),
  s({ trig = "\\prod" },
    fmta("\\prod_{<>=<>}^{<>} <>", { i(1, "i"), i(2, "1"), i(3, "N"), i(4) }),
    { condition = in_mathzone }
  ),

  -- ── Comparisons ───────────────────────────────────────────────────────────
  s({ trig = "===",  snippetType = "autosnippet" }, { t("\\equiv") },  { condition = in_mathzone }),
  s({ trig = "!=",   snippetType = "autosnippet" }, { t("\\neq") },    { condition = in_mathzone }),
  s({ trig = ">=",   snippetType = "autosnippet" }, { t("\\geq") },    { condition = in_mathzone }),
  s({ trig = "<=",   snippetType = "autosnippet" }, { t("\\leq") },    { condition = in_mathzone }),
  s({ trig = ">>",   snippetType = "autosnippet" }, { t("\\gg") },     { condition = in_mathzone }),
  s({ trig = "<<",   snippetType = "autosnippet" }, { t("\\ll") },     { condition = in_mathzone }),
  s({ trig = "simm", snippetType = "autosnippet" }, { t("\\sim") },    { condition = in_mathzone }),
  s({ trig = "sim=", snippetType = "autosnippet" }, { t("\\simeq") },  { condition = in_mathzone }),
  s({ trig = "prop", snippetType = "autosnippet" }, { t("\\propto") }, { condition = in_mathzone }),
  s({ trig = "osimm", snippetType = "autosnippet" },
    fmta("\\overset{ <> }{\\sim} <>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),

  -- ── Arrows ────────────────────────────────────────────────────────────────
  s({ trig = "<->", snippetType = "autosnippet" }, { t("\\leftrightarrow ") }, { condition = in_mathzone }),
  s({ trig = "->",  snippetType = "autosnippet" }, { t("\\to") },             { condition = in_mathzone }),
  s({ trig = "!>",  snippetType = "autosnippet" }, { t("\\mapsto") },         { condition = in_mathzone }),
  s({ trig = "=>",  snippetType = "autosnippet" }, { t("\\implies") },        { condition = in_mathzone }),
  s({ trig = "=<",  snippetType = "autosnippet" }, { t("\\impliedby") },      { condition = in_mathzone }),

  -- ── Sets ──────────────────────────────────────────────────────────────────
  s({ trig = "and",   snippetType = "autosnippet" }, { t("\\cap") },      { condition = in_mathzone }),
  s({ trig = "orr",   snippetType = "autosnippet" }, { t("\\cup") },      { condition = in_mathzone }),
  s({ trig = "inn",   snippetType = "autosnippet" }, { t("\\in") },       { condition = in_mathzone }),
  s({ trig = "notin", snippetType = "autosnippet" }, { t("\\not\\in") },  { condition = in_mathzone }),
  s({ trig = "sub=",  snippetType = "autosnippet" }, { t("\\subseteq") }, { condition = in_mathzone }),
  s({ trig = "sup=",  snippetType = "autosnippet" }, { t("\\supseteq") }, { condition = in_mathzone }),
  s({ trig = "eset",  snippetType = "autosnippet" }, { t("\\emptyset") }, { condition = in_mathzone }),
  s({ trig = "set", snippetType = "autosnippet" },
    fmta("\\{ <> \\}<>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),

  -- ── Calligraphic / Blackboard bold ───────────────────────────────────────
  s({ trig = "LL", snippetType = "autosnippet" }, { t("\\mathcal{L}") }, { condition = in_mathzone }),
  s({ trig = "HH", snippetType = "autosnippet" }, { t("\\mathcal{H}") }, { condition = in_mathzone }),
  s({ trig = "CC", snippetType = "autosnippet" }, { t("\\mathbb{C}") },  { condition = in_mathzone }),
  s({ trig = "RR", snippetType = "autosnippet" }, { t("\\mathbb{R}") },  { condition = in_mathzone }),
  s({ trig = "ZZ", snippetType = "autosnippet" }, { t("\\mathbb{Z}") },  { condition = in_mathzone }),
  s({ trig = "NN", snippetType = "autosnippet" }, { t("\\mathbb{N}") },  { condition = in_mathzone }),

  -- ── Derivatives & integrals ───────────────────────────────────────────────
  -- "par" is NOT autosnippet (options: "m" in original)
  s({ trig = "par" },
    fmta("\\frac{ \\partial <> }{ \\partial <> } <>", { i(1, "y"), i(2, "x"), i(3) }),
    { condition = in_mathzone }
  ),
  s({ trig = "ddt", snippetType = "autosnippet" }, { t("\\frac{d}{dt} ") }, { condition = in_mathzone }),
  -- \int expansion (manual, not auto)
  s({ trig = "\\int" },
    fmta("\\int <> \\, d<> <>", { i(1), i(2, "x"), i(3) }),
    { condition = in_mathzone }
  ),
  s({ trig = "dint", snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>} <> \\, d<> <>", { i(1, "0"), i(2, "1"), i(3), i(4, "x"), i(5) }),
    { condition = in_mathzone }
  ),
  s({ trig = "oint",  snippetType = "autosnippet" }, { t("\\oint") },  { condition = in_mathzone }),
  s({ trig = "iint",  snippetType = "autosnippet" }, { t("\\iint") },  { condition = in_mathzone }),
  s({ trig = "iiint", snippetType = "autosnippet" }, { t("\\iiint") }, { condition = in_mathzone }),
  s({ trig = "oinf", snippetType = "autosnippet" },
    fmta("\\int_{0}^{\\infty} <> \\, d<> <>", { i(1), i(2, "x"), i(3) }),
    { condition = in_mathzone }
  ),
  s({ trig = "infi", snippetType = "autosnippet" },
    fmta("\\int_{-\\infty}^{\\infty} <> \\, d<> <>", { i(1), i(2, "x"), i(3) }),
    { condition = in_mathzone }
  ),

  -- ── Trigonometry (auto-backslash) ─────────────────────────────────────────
  s({ trig = "([^\\\\])(arcsin|arccos|arctan|sin|cos|tan|csc|sec|cot)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip) return snip.captures[1] .. "\\" .. snip.captures[2] end),
    { condition = in_mathzone }
  ),

  -- ── Physics ───────────────────────────────────────────────────────────────
  s({ trig = "kbt",  snippetType = "autosnippet" }, { t("k_{B}T") },     { condition = in_mathzone }),
  s({ trig = "msun", snippetType = "autosnippet" }, { t("M_{\\odot}") }, { condition = in_mathzone }),

  -- ── Quantum mechanics ─────────────────────────────────────────────────────
  s({ trig = "dag", snippetType = "autosnippet" }, { t("^{\\dagger}") }, { condition = in_mathzone }),
  s({ trig = "o+",  snippetType = "autosnippet" }, { t("\\oplus ") },   { condition = in_mathzone }),
  s({ trig = "ox",  snippetType = "autosnippet" }, { t("\\otimes ") },  { condition = in_mathzone }),
  s({ trig = "bra", snippetType = "autosnippet" },
    fmta("\\bra{<>} <>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "ket", snippetType = "autosnippet" },
    fmta("\\ket{<>} <>", { i(1), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "brk", snippetType = "autosnippet" },
    fmta("\\braket{ <> | <> } <>", { i(1), i(2), i(3) }),
    { condition = in_mathzone }
  ),
  s({ trig = "outer", snippetType = "autosnippet" },
    fmta("\\ket{<>} \\bra{<>} <>", { i(1, "\\psi"), rep(1), i(2) }),
    { condition = in_mathzone }
  ),

  -- ── Chemistry ─────────────────────────────────────────────────────────────
  s({ trig = "pu",  snippetType = "autosnippet" }, fmta("\\pu{ <> }", { i(1) }),  { condition = in_mathzone }),
  s({ trig = "cee", snippetType = "autosnippet" }, fmta("\\ce{ <> }", { i(1) }),  { condition = in_mathzone }),
  s({ trig = "he4", snippetType = "autosnippet" }, { t("{}^{4}_{2}He ") },        { condition = in_mathzone }),
  s({ trig = "he3", snippetType = "autosnippet" }, { t("{}^{3}_{2}He ") },        { condition = in_mathzone }),
  s({ trig = "iso", snippetType = "autosnippet" },
    fmta("{}^{<>}_{<>}<>", { i(1, "4"), i(2, "2"), i(3, "He") }),
    { condition = in_mathzone }
  ),

  -- ── Matrix environments ───────────────────────────────────────────────────
  s({ trig = "pmat",   snippetType = "autosnippet" }, fmta("\\begin{pmatrix}\n<>\n\\end{pmatrix}",   { i(1) }), { condition = in_mathzone }),
  s({ trig = "bmat",   snippetType = "autosnippet" }, fmta("\\begin{bmatrix}\n<>\n\\end{bmatrix}",   { i(1) }), { condition = in_mathzone }),
  s({ trig = "Bmat",   snippetType = "autosnippet" }, fmta("\\begin{Bmatrix}\n<>\n\\end{Bmatrix}",   { i(1) }), { condition = in_mathzone }),
  s({ trig = "vmat",   snippetType = "autosnippet" }, fmta("\\begin{vmatrix}\n<>\n\\end{vmatrix}",   { i(1) }), { condition = in_mathzone }),
  s({ trig = "Vmat",   snippetType = "autosnippet" }, fmta("\\begin{Vmatrix}\n<>\n\\end{Vmatrix}",   { i(1) }), { condition = in_mathzone }),
  s({ trig = "matrix", snippetType = "autosnippet" }, fmta("\\begin{matrix}\n<>\n\\end{matrix}",     { i(1) }), { condition = in_mathzone }),
  s({ trig = "cases",  snippetType = "autosnippet" }, fmta("\\begin{cases}\n<>\n\\end{cases}",       { i(1) }), { condition = in_mathzone }),
  s({ trig = "align",  snippetType = "autosnippet" }, fmta("\\begin{aligned}\n<>\n\\end{aligned}",       { i(1) }), { condition = in_mathzone }),
  s({ trig = "array",  snippetType = "autosnippet" }, fmta("\\begin{array}\n<>\n\\end{array}",       { i(1) }), { condition = in_mathzone }),

  -- ── Brackets ──────────────────────────────────────────────────────────────
  s({ trig = "avg",   snippetType = "autosnippet" }, fmta("\\langle <> \\rangle <>", { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "norm",  snippetType = "autosnippet" }, fmta("\\lvert <> \\rvert <>",   { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "Norm",  snippetType = "autosnippet" }, fmta("\\lVert <> \\rVert <>",   { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "ceil",  snippetType = "autosnippet" }, fmta("\\lceil <> \\rceil <>",   { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "floor", snippetType = "autosnippet" }, fmta("\\lfloor <> \\rfloor <>", { i(1), i(2) }), { condition = in_mathzone }),
  s({ trig = "mod",   snippetType = "autosnippet" }, fmta("|<>|<>",                  { i(1), i(2) }), { condition = in_mathzone }),
s({ trig = "lr(",  snippetType = "autosnippet", wordTrig = false }, fmta("\\left( <> \\right) <>",     { i(1), i(2) }), { condition = in_mathzone }),
s({ trig = "lr{",  snippetType = "autosnippet", wordTrig = false }, fmta("\\left\\{ <> \\right\\} <>", { i(1), i(2) }), { condition = in_mathzone }),
s({ trig = "lr[",  snippetType = "autosnippet", wordTrig = false }, fmta("\\left[ <> \\right] <>",     { i(1), i(2) }), { condition = in_mathzone }),
s({ trig = "lr|",  snippetType = "autosnippet", wordTrig = false }, fmta("\\left| <> \\right| <>",     { i(1), i(2) }), { condition = in_mathzone }),
s({ trig = "lra",  snippetType = "autosnippet", wordTrig = false }, fmta("\\left<< <> \\right>> <>",   { i(1), i(2) }), { condition = in_mathzone }),

  -- ── Visual selection operations ───────────────────────────────────────────
  -- Select text in visual mode, then trigger these to wrap the selection.
  s({ trig = "U", snippetType = "autosnippet" },
    fmta("\\underbrace{ <> }_{ <> }", { d(1, visual_selection), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "O", snippetType = "autosnippet" },
    fmta("\\overbrace{ <> }^{ <> }", { d(1, visual_selection), i(2) }),
    { condition = in_mathzone }
  ),
  s({ trig = "B", snippetType = "autosnippet" },
    fmta("\\underset{ <> }{ <> }", { i(1), d(2, visual_selection) }),
    { condition = in_mathzone }
  ),
  s({ trig = "C", snippetType = "autosnippet" },
    fmta("\\cancel{ <> }", { d(1, visual_selection) }),
    { condition = in_mathzone }
  ),
  s({ trig = "K", snippetType = "autosnippet" },
    fmta("\\cancelto{ <> }{ <> }", { i(1), d(2, visual_selection) }),
    { condition = in_mathzone }
  ),
  s({ trig = "S", snippetType = "autosnippet" },
    fmta("\\sqrt{ <> }", { d(1, visual_selection) }),
    { condition = in_mathzone }
  ),

  -- ── Misc ──────────────────────────────────────────────────────────────────
  s({ trig = "tayl", snippetType = "autosnippet" },
    fmta("<>(<> + <>) = <>(<>) + <>'(<>)<> + <>''(<>) \\frac{<>^{2}}{2!} + \\dots<>", {
      i(1, "f"),  -- 1: function name
      i(2, "x"),  -- 2: variable
      i(3, "h"),  -- 3: increment
      rep(1), rep(2),
      rep(1), rep(2), rep(3),
      rep(1), rep(2), rep(3),
      i(4),
    }),
    { condition = in_mathzone }
  ),

  -- ── Identity matrix generator (e.g. iden3 → 3×3 identity) ────────────────
  s({ trig = "iden(%d)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      local n = tonumber(snip.captures[1])
      local str = "\\begin{pmatrix}\n"
      for r = 1, n do
        for c = 1, n do
          str = str .. (r == c and "1" or "0")
          if c < n then str = str .. " & " end
        end
        if r < n then str = str .. " \\\\\n" end
      end
      return str .. "\n\\end{pmatrix}"
    end),
    { condition = in_mathzone }
  ),
}
