defmodule RedirectTo.LinkTest do
  use RedirectTo.ModelCase
  alias RedirectTo.Link

  @valid_attrs %{long_url: "http://www.example.com", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Link.changeset(%Link{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "URL validation" do
    {:long_url, message} = Link.changeset(%Link{}, %{long_url: "invalid"})
                            |> error_by_attribute(:long_url)
    assert message == "should be a valid URL"
  end

  defp error_by_attribute(changeset, attribute) do
    changeset.errors
    |> Enum.find(fn({attr, _msg}) -> attr == attribute end)
  end
end
