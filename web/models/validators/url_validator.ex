defmodule RedirectTo.UrlValidator do
  import Ecto.Changeset

  def validate_url(changeset, attribute) do
    case parse_url(changeset.changes[attribute]) do
      {:error, _uri} ->
        changeset
        |> add_error(attribute, "should be a valid URL")
      {:ok, _uri} ->
        changeset
    end
  end

  defp parse_url(nil), do: {:error, URI.parse("")}
  defp parse_url(value) do
    uri = URI.parse(value)
    case uri do
      %URI{scheme: nil} -> {:error, uri}
      %URI{host: nil} -> {:error, uri}
      _ -> {:ok, uri}
    end
  end
end

