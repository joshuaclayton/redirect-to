defmodule RedirectTo.LinkCreator do
  alias RedirectTo.Repo
  alias RedirectTo.Link
  alias RedirectTo.TokenGenerator

  def create(link_params) do
    link = Link.changeset(%Link{}, link_params)

    case Repo.insert(link) do
      {:ok, link} -> link |> generate_token
      error -> error
    end
  end

  defp generate_token(link) do
    Repo.update(%{link | slug: TokenGenerator.generate(link.id)})
  end
end
