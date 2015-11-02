defmodule RedirectTo.PageController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link

  def index(conn, _params) do
    link = Link.changeset(%Link{})
    render conn, "index.html", link: link
  end
end
