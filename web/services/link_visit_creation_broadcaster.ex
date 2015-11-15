defmodule RedirectTo.LinkVisitCreationBroadcaster do
  import Ecto.Query, only: [from: 2]
  alias RedirectTo.Repo
  alias RedirectTo.Link
  alias RedirectTo.LinkVisit

  def broadcast(link_visit) do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:link",
      %{
        link_id: link_visit.link_id,
        link_list_item_html: link_list_item_html(link_visit),
        link_visit_table_row_html: link_visit_table_row_html(link_visit)
      }
    )
  end

  defp link_list_item_html(link_visit) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkView,
      "_list_item.html",
      conn: RedirectTo.Endpoint,
      link: link_from_link_visit(link_visit),
      visit_count: link_visit_count(link_visit),
    )
  end

  defp link_visit_table_row_html(link_visit) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkVisitView,
      "_table_row.html",
      conn: RedirectTo.Endpoint,
      link_visit: link_visit
    )
  end

  defp link_from_link_visit(link_visit) do
    Repo.get!(Link, link_visit.link_id)
  end

  defp link_visit_count(link_visit) do
    from(
      lv in LinkVisit,
      where: lv.link_id == ^link_visit.link_id,
      select: count(lv.id)
    ) |> Repo.one
  end
end
