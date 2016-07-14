defmodule RedirectTo.RedirectController do
  use RedirectTo.Web, :controller
  alias RedirectTo.LinkVisitCreator
  alias RedirectTo.Queries

  def show(conn, %{"slug" => slug}) do
    link = case System.get_env("USE_LINK_CACHE") do
      "true" ->
        LinkCache.Cache.fetch(slug, fn ->
          Queries.Link.by_slug(slug) |> Repo.one
        end)
      _ -> Queries.Link.by_slug(slug) |> Repo.one
    end

    case System.get_env("TRACK_VISIT_STATISTICS") do
      "true" -> spawn_link(LinkVisitCreator, :create, [conn, link])
      _ -> nil
    end

    redirect conn, external: link.long_url
  end
end
