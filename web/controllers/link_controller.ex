defmodule RedirectTo.LinkController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link
  alias RedirectTo.LinkCreator

  plug :scrub_params, "link" when action in [:create]

  def index(conn, _params) do
    new_link = Link.changeset
    render conn, "index.html", new_link: new_link, links: load_links
  end

  def create(conn, %{"link" => link_params}) do
    case LinkCreator.create(link_params) do
      {:ok, link} ->
        put_flash(conn, :info, I18n.t!("en", "link.created", url: link.long_url))
        |> redirect to: link_path(conn, :index)
      {:error, changeset} ->
        render conn, "index.html", links: load_links, new_link: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    link_visits_query = RedirectTo.Queries.NewLinkVisits.new
    link = Repo.get!(Link, id) |> Repo.preload([link_visits: link_visits_query])

    new_link = Link.changeset
    render conn, "show.html", new_link: new_link, link: link, links: load_links
  end

  defp load_links do
    RedirectTo.Queries.LinksList.with_visits_count
    |> Repo.all
  end
end
