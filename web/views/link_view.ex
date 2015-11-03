defmodule RedirectTo.LinkView do
  use RedirectTo.Web, :view
  alias RedirectTo.Repo

  def visits_count(link) do
    link.link_visits |> length
  end
end
