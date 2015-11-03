defmodule RedirectTo.LinkController do
  use RedirectTo.Web, :controller
  alias RedirectTo.Link
  alias RedirectTo.TokenGenerator

  def index(conn, _params) do
    link = Link.changeset(%Link{})
    links = Repo.all(Link)
    render conn, "index.html", link: link, links: links
  end

  def create(conn, %{"link" => link_params}) do
    link = Link.changeset(%Link{}, link_params)

    case Repo.insert(link) do
      {:ok, link} ->
        Repo.update(%{link | slug: TokenGenerator.generate(link.id)})

        put_flash(conn, :info, I18n.t!("en", "link.created", url: link.long_url))
        |> redirect to: link_path(conn, :index)
      {:error, _changeset} ->

    end
  end

  def show(conn, %{"id" => slug}) do
    link = Repo.get_by!(Link, slug: slug)

    redirect conn, external: link.long_url
  end
end
