defmodule RedirectTo.GeocoderTest do
  use ExUnit.Case

  alias RedirectTo.Geocoder

  test "handles when no IP is provided" do
    assert Geocoder.geocode_country(nil) == nil
  end

  test "geocodes country with generic IP" do
    assert Geocoder.geocode_country("127.0.0.1") == nil
  end

  test "geocodes country with US-based IP" do
    assert Geocoder.geocode_country("173.166.164.121") == "US"
  end
end
