defmodule RedirectTo.LinkController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link
  alias RedirectTo.LinkCreator

  def index(conn, _params) do
    link = Link.changeset
    render conn, "index.html", link: link, links: load_links
  end

  def create(conn, %{"link" => link_params}) do
    case LinkCreator.create(link_params) do
      {:ok, link} ->
        put_flash(conn, :info, I18n.t!("en", "link.created", url: link.long_url))
        |> redirect to: link_path(conn, :index)
      {:error, changeset} ->
        render conn, "index.html", link: changeset, links: load_links
    end
  end

  defp load_links do
    Repo.all(Link)
    |> Repo.preload([:link_visits])
  end
end
