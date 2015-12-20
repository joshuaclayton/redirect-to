defmodule RedirectTo.LinkCreator do
  alias RedirectTo.Repo
  alias RedirectTo.Link
  alias RedirectTo.TokenGenerator

  def create(link_params) do
    Link.changeset(%Link{}, link_params)
    |> Repo.insert
    |> case do
      {:ok, link} -> link |> generate_token
      error -> error
    end
  end

  defp generate_token(link) do
    link
    |> Link.changeset(%{slug: TokenGenerator.generate(link.id)})
    |> Repo.update
  end
end
