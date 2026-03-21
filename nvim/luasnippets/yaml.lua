local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node

return {
  snippet("# yaml", text({ "# yaml-language-server: $schema=" })),
}
