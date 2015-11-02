defmodule RedirectTo.PageController do
  use RedirectTo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
