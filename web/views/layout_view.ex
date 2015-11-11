defmodule RedirectTo.LayoutView do
  use RedirectTo.Web, :view

  def split_to_spans(text) do
    text
    |> String.split(" ")
    |> Enum.map(fn(split) ->
      "<span>#{split}</span>"
    end)
    |> Enum.join(" ")
  end
end
