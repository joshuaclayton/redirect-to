defmodule RedirectTo.LinkVisitCreator do
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit

  def create(conn, link) do
    params = Map.merge %{link_id: link.id}, request_info(conn)

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
end
