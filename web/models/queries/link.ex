defmodule RedirectTo.Queries.Link do
  import Ecto.Query
  alias RedirectTo.Link

  def by_slug(slug) do
    from l in Link, where: l.slug == ^slug
  end
end
