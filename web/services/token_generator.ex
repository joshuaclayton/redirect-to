defmodule RedirectTo.TokenGenerator do
  @list [ ?A..?Z | [?a..?z | [?0..?9]]]

  def list do
    @list
    |> Enum.flat_map(fn(x) -> x end)
  end

  def generate(id) do
    list_from_id(id)
    |> Enum.map(fn(x) -> Enum.at(list, x) end)
    |> to_string
  end

  defp list_from_id(id) do
    id = id - 1
    offset = div(id, length(list))
    remainder = rem(id, length(list))

    cond do
      offset > 0 ->
        [list_from_id(offset) | [remainder]]
        |> List.flatten
      true ->
        [remainder]
    end
  end
end
