local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node

return {
  snippet("debug", text({"use Data::Printer;", "$DB::single=1;"})),
  snippet({trig = "print_object", name = "print object"},
          {text({"use Data::Printer;", "p("}), insert(1, "variable"), text(");")}),
  snippet({trig = "create_logger", name = "creates simple logger"},
          {text("my $logger = Meteologica::Log::Delegados::LogPantalla->new();")}),
  snippet({trig = "create_database", name = "creates database object"},
          {text("my $database = Meteologica::BaseDatos::EOLICA(host => "), insert(1), text(", logger => $logger);")}),
  snippet({trig = "getopt", name = "Parse program arguments"}, {
    text({"use Getopt::Long::Descriptive;", "", "my ( $opt, $usage ) =", "  describe_options( '%c %o',", "  ["}),
    insert(1, "nombre_parametro"), text(","), insert(2, "descripcion_parametro"), text({
      "],", "  ['help', 'Muestra la ayuda y sale' ],", "  );", "if ( $opt->help) {", "  print($usage->text);",
      "  exit;", "}"
    })
  })
}
