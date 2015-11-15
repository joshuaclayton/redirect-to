defmodule RedirectTo.LinkVisitCreator do
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit
  alias RedirectTo.LinkVisitCreationBroadcaster
  import Ecto.Query, only: [from: 1, from: 2]
  import RedirectTo.UserAgent, only: [user_agent_to_map: 1]


  def create(conn, link) do
    %{link_id: link.id}
    |> Map.merge(request_info(conn))
    |> with_user_agent_attributes
    |> persist_link_visit
    |> LinkVisitCreationBroadcaster.broadcast
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

  defp persist_link_visit(attributes) do
    LinkVisit.changeset(%LinkVisit{}, attributes)
    |> Repo.insert!
  end
end
