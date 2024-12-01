import gleam/int
import gleam/io
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

pub fn regex_para_lista_organizada(
  input: String,
  regex: regexp.Regexp,
) -> List(Int) {
  regexp.replace(each: regex, in: input, with: "")
  |> string.split(on: "\n")
  |> list.map(fn(x) { int.parse(x) |> result.unwrap(0) })
  |> list.sort(by: int.compare)
}

pub fn pt_1(input: String) {
  let assert Ok(regex_default) = regexp.from_string("[0-9]*")

  let lista_esquerda =
    regexp.compile(
      " +[0-9]+$",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_default)
    |> regex_para_lista_organizada(input, _)

  let lista_direita =
    regexp.compile(
      "^[0-9]+ +",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_default)
    |> regex_para_lista_organizada(input, _)

  let lista_distancia =
    list.map2(lista_esquerda, lista_direita, fn(x, y) {
      int.subtract(x, y)
      |> int.absolute_value
    })

  lista_distancia
  |> int.sum
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
