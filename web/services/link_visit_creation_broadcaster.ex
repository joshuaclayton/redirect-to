defmodule RedirectTo.LinkVisitCreationBroadcaster do
  import Ecto.Query, only: [from: 2]
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit

  def broadcast(link_visit, link) do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:link",
      %{
        link_id: link.id,
        link_list_item_html: link_list_item_html(link),
        link_analytics_html: link_analytics_html(link),
        link_visit_table_row_html: link_visit_table_row_html(link_visit)
      }
    )
  end

  defp link_list_item_html(link) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkView,
      "_list_item.html",
      conn: RedirectTo.Endpoint,
      link: link,
      visit_count: link_visit_count(link),
    )
  end

  defp link_analytics_html(link) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkAnalyticsView,
      "show.html",
      conn: RedirectTo.Endpoint,
      link: link
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

  defp link_visit_count(link) do
    from(
      lv in LinkVisit,
      where: lv.link_id == ^link.id,
      select: count(lv.id)
    ) |> Repo.one
  end
end
