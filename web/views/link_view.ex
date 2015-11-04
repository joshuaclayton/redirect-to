defmodule RedirectTo.LinkView do
  use RedirectTo.Web, :view

  def visits_count(link) do
    link.link_visits |> length
  end
end
