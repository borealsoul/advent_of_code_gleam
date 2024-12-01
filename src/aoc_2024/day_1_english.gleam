import gleam/int
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

pub fn parse_to_sorted_list(input: String, regex: regexp.Regexp) -> List(Int) {
  regexp.replace(each: regex, in: input, with: "")
  |> string.split(on: "\n")
  |> list.map(fn(x) { int.parse(x) |> result.unwrap(0) })
  |> list.sort(by: int.compare)
}

pub fn pt_1(input: String) -> Int {
  let assert Ok(regex_default) = regexp.from_string("[0-9]*")

  let left_side =
    regexp.compile(
      " +[0-9]+$",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_default)
    |> parse_to_sorted_list(input, _)

  let right_side =
    regexp.compile(
      "^[0-9]+ +",
      with: regexp.Options(case_insensitive: False, multi_line: True),
    )
    |> result.unwrap(regex_default)
    |> parse_to_sorted_list(input, _)

  let distance_between_lists =
    list.map2(left_side, right_side, fn(x, y) {
      int.subtract(x, y)
      |> int.absolute_value
    })

  distance_between_lists
  |> int.sum
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
