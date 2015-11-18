defmodule RedirectTo.LinkVisitCreator do
  alias RedirectTo.Repo
  alias RedirectTo.LinkVisit
  alias RedirectTo.LinkVisitCreationBroadcaster
  import RedirectTo.UserAgent, only: [user_agent_to_map: 1]
  import RedirectTo.Geocoder, only: [geocode_country: 1]

  def create(conn, link) do
    %{link_id: link.id}
    |> Map.merge(request_info(conn))
    |> with_user_agent_attributes
    |> with_geocoded_attributes
    |> persist_link_visit
    |> broadcast_link_visit_creation(link)
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

  defp with_geocoded_attributes(map = %{ip: ip}) do
    Map.merge map, %{country_code: geocode_country(ip)}
  end

  defp persist_link_visit(attributes) do
    LinkVisit.changeset(%LinkVisit{}, attributes)
    |> Repo.insert!
  end

  defp broadcast_link_visit_creation(link_visit, link) do
    LinkVisitCreationBroadcaster.broadcast(link_visit, link)
  end
end
