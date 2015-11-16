defmodule RedirectTo.Queries.NewLinkVisits do
  import Ecto.Query
  alias RedirectTo.LinkVisit

  def new(query \\ LinkVisit) do
    from lv in query,
      order_by: [desc: lv.inserted_at]
  end
end
