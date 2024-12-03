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
    |> list.filter_map(int.parse)
  })
}

pub fn pt_1(input: List(List(Int))) -> Int {
  input
  |> list.map(fn(relatorio) {
    let relatorio_ordenado = relatorio |> list.sort(int.compare)

    // Caso o relatório for igual a ele mesmo ordenado, ou de trás-para-frente...
    case
      relatorio == relatorio_ordenado,
      relatorio == list.reverse(relatorio_ordenado)
    {
      False, False -> False
      // Se qualquer um dos casos for verdade...
      //  Divide o relatório em pares,
      //  Mapeia-o, retornando o valor absoluto da diferença do par,
      //  Se todos os elementos da lista forem >= 1 e <= 3, retorna True.
      _, _ -> {
        relatorio
        |> list.window_by_2
        |> list.map(fn(par) { int.absolute_value(par.0 - par.1) })
        |> list.all(fn(nivel) { nivel >= 1 && nivel <= 3 })
      }
    }
  })
  // Conta quantos True existem na lista de relatórios.
  |> list.count(fn(relatorio) { relatorio == True })
}

pub fn pt_2(input: List(List(Int))) {
  todo as "part 2 not implemented"
}
