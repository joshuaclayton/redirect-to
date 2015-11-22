defmodule RedirectTo.Geocoder do
  def geocode_country(nil), do: nil
  def geocode_country(ip) do
    Geolix.lookup(ip)
    |> identify_country
  end

  defp identify_country(%{country: nil}), do: nil
  defp identify_country(%{country: %{country: %{iso_code: iso_code}}}), do: iso_code
end
