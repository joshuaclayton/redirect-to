defmodule RedirectTo.RedirectController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link
  alias RedirectTo.LinkVisitCreator

  def show(conn, %{"slug" => slug}) do
    link = Repo.get_by!(Link, slug: slug)

    spawn(LinkVisitCreator, :create, [conn, link])

    redirect conn, external: link.long_url
  end
end
