defmodule RedirectTo.LinkVisitCreator do
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit
  import RedirectTo.UserAgent, only: [user_agent_to_map: 1]

  def create(conn, link) do
    params = %{link_id: link.id}
             |> Map.merge request_info(conn)
             |> with_user_agent_attributes

    LinkVisit.changeset(%LinkVisit{}, params)
    |> Repo.insert!
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
end
