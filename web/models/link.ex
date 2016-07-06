defmodule RedirectTo.Link do
  use RedirectTo.Web, :model
  alias RedirectTo.LinkVisit

  schema "links" do
    field :long_url, :string
    field :slug, :string
    field :link_visits_count, :integer, default: 0

    has_many :link_visits, LinkVisit, on_delete: :delete_all

    timestamps
  end

  @required_fields ~w(long_url)
  @optional_fields ~w(slug)

  def changeset(model \\ %__MODULE__{}, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_url(:long_url)
  end
end
