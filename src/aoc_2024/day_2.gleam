import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

/// Gera uma Lista de uma Lista de Int seguindo:
/// 7 6 4 2 1 <-- Relatório
/// ^ ^ ^ ^ ^
/// . . . . . <-- Níveis
///
/// Ou seja, Uma lista (a cada \n) de uma lista de Ints (a cada espaço)
///
pub fn parse(input: String) -> List(List(Int)) {
  input
  |> string.split(on: "\n")
  |> list.map(fn(relatorio) {
    relatorio
    |> string.split(on: " ")
    |> list.map(fn(nivel) {
      nivel
      |> int.parse
      |> result.unwrap(0)
    })
  })
}

pub fn pt_1(input: List(List(Int))) -> Int {
  input
  |> list.map(fn(relatorio) {
    let relatorio_ordenado = relatorio |> list.sort(int.compare)

    case
      relatorio == relatorio_ordenado,
      relatorio == list.reverse(relatorio_ordenado)
    {
      False, False -> io.debug(False)
      False, True | True, False -> {
        io.debug(relatorio)
        io.debug(relatorio_ordenado)
        relatorio
        |> list.window_by_2
        |> list.map(fn(par) { int.absolute_value(par.0 - par.1) })
        |> io.debug
        |> list.all(fn(nivel) { nivel >= 1 && nivel <= 3 })
      }
      _, _ -> io.debug(False)
    }
    // relatorio == relatorio_ordenado
    // || relatorio
    // == relatorio_ordenado_reverso
    // |> io.debug
  })
  |> list.count(fn(nivel) { nivel == True })
}

pub fn pt_2(input: List(List(Int))) {
  todo as "part 2 not implemented"
}
