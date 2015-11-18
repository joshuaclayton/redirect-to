defmodule RedirectTo.LinkVisitCreationBroadcaster do
  alias RedirectTo.Repo

  @link_count_update_frequency 5
  @analytics_update_frequency 5

  def broadcast(link_visit, link) do
    %{link_visit: link_visit, link: link, visit_count: visit_count(link)}
    |> broadcast_link_visit_creation
    |> broadcast_link_count_update(frequency: @link_count_update_frequency)
    |> broadcast_analytics(frequency: @analytics_update_frequency)
  end

  defp broadcast_link_visit_creation(map = %{link_visit: link_visit, link: link}) do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:link",
      %{
        link_id: link.id,
        link_visit_table_row_html: link_visit_table_row_html(link_visit)
      }
    )

    map
  end

  defp broadcast_link_count_update(map = %{visit_count: visit_count}, [frequency: frequency]) when rem(visit_count, frequency) != 0, do: map
  defp broadcast_link_count_update(map = %{link: link, visit_count: visit_count}, [frequency: frequency]) when rem(visit_count, frequency) == 0 do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:linkCount",
      %{
        link_id: link.id,
        link_list_item_html: link_list_item_html(link, visit_count),
      }
    )

    map
  end

  defp broadcast_analytics(map = %{visit_count: visit_count}, [frequency: frequency]) when rem(visit_count, frequency) != 0, do: map
  defp broadcast_analytics(map = %{link: link, visit_count: visit_count}, [frequency: frequency]) when rem(visit_count, frequency) == 0 do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:linkAnalytics",
      %{
        link_id: link.id,
        link_analytics_html: link_analytics_html(link),
      }
    )

    map
  end

  defp link_list_item_html(link, visit_count) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkView,
      "_list_item.html",
      conn: RedirectTo.Endpoint,
      link: link,
      visit_count: visit_count,
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

  defp visit_count(link) do
    import Ecto.Query, only: [from: 2]

    from(
      l in RedirectTo.Link,
      select: l.link_visits_count,
      where: l.id == ^link.id
    )
    |> Repo.one
  end
end
