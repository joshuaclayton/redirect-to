defmodule RedirectTo.RedirectController do
  use RedirectTo.Web, :controller
  alias RedirectTo.LinkVisitCreator
  alias RedirectTo.Queries

  def show(conn, %{"slug" => slug}) do
    link = Queries.Link.by_slug(slug) |> Repo.one

    spawn_link(LinkVisitCreator, :create, [conn, link])

    redirect conn, external: link.long_url
  end
end
