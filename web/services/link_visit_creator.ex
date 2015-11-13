defmodule RedirectTo.LinkVisitCreator do
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit
  alias RedirectTo.Link
  import Ecto.Query, only: [from: 1, from: 2]
  import RedirectTo.UserAgent, only: [user_agent_to_map: 1]


  def create(conn, link) do
    params = %{link_id: link.id}
             |> Map.merge request_info(conn)
             |> with_user_agent_attributes

    LinkVisit.changeset(%LinkVisit{}, params)
    |> Repo.insert!
    |> broadcast_link_visit_creation
  end

  defp request_info(conn) do
    %{
      user_agent: conn.req_headers["user-agent"],
      ip: conn.req_headers["x-forwarded-for"],
      referer: conn.req_headers["referer"],
    }
  end

  defp with_user_agent_attributes(map) do
    Map.merge map, user_agent_to_map(map.user_agent)
  end

  defp broadcast_link_visit_creation(link_visit) do
    RedirectTo.Endpoint.broadcast!(
      "links",
      "update:link",
      %{
        link_id: link_visit.link_id,
        html: link_visit_html(link_visit)
      }
    )
  end

  defp link_visit_html(link_visit) do
    Phoenix.View.render_to_string(
      RedirectTo.LinkView,
      "_list_item.html",
      conn: RedirectTo.Endpoint,
      link: link_from_link_visit(link_visit),
      visit_count: link_visit_count(link_visit),
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
