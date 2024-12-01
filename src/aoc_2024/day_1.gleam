import gleam/int
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

pub fn parse(input: String) -> #(List(Int), List(Int)) {
  let assert Ok(regex_padrao) = regexp.from_string("[0-9]*")

  let lista_esquerda =
    regexp.compile(
      " +[0-9]+$",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_padrao)
    |> string_para_lista_ordenada(input, _)

  let lista_direita =
    regexp.compile(
      "^[0-9]+ +",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_padrao)
    |> string_para_lista_ordenada(input, _)

  #(lista_esquerda, lista_direita)
}

/// Recebe uma string e um Regex,
/// e o usa para separa a string em listas, passa os itens para Int e os ordena.
///
pub fn string_para_lista_ordenada(
  input: String,
  regex: regexp.Regexp,
) -> List(Int) {
  regexp.replace(each: regex, in: input, with: "")
  |> string.split(on: "\n")
  |> list.map(fn(x) { int.parse(x) |> result.unwrap(0) })
  |> list.sort(by: int.compare)
}

pub fn pt_1(input: #(List(Int), List(Int))) -> Int {
  list.map2(input.0, input.1, fn(x, y) {
    int.subtract(x, y)
    |> int.absolute_value
  })
  |> int.sum
}

pub fn pt_2(input: #(List(Int), List(Int))) {
  // Inspiração de @metruzanca do servidor de Gleam no Discord 
  // (desculpa, eu fiquei travada)
  input.0
  |> list.map(fn(item_esquerdo) {
    list.count(input.1, where: fn(item_direito) {
      item_esquerdo == item_direito
    })
    * item_esquerdo
  })
  |> int.sum
}
