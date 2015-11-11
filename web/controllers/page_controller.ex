defmodule RedirectTo.PageController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link

  def homepage(conn, _params) do
    link = Link.changeset
    render conn, "homepage.html", link: link
  end
end
