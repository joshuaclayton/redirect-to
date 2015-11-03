defmodule RedirectTo.RedirectController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link

  def show(conn, %{"slug" => slug}) do
    link = Repo.get_by!(Link, slug: slug)

    redirect conn, external: link.long_url
  end
end
