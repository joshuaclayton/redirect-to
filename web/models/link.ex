defmodule RedirectTo.Link do
  use RedirectTo.Web, :model
  alias RedirectTo.LinkVisit

  schema "links" do
    field :long_url, :string
    field :slug, :string

    has_many :link_visits, LinkVisit, on_delete: :fetch_and_delete

    timestamps
  end

  @required_fields ~w(long_url)
  @optional_fields ~w()

  def changeset(model \\ %__MODULE__{}, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_url(:long_url)
  end
end
