defmodule RedirectTo.LinkVisit do
  use RedirectTo.Web, :model

  schema "link_visits" do
    field :ip, :string
    field :referer, :string
    field :user_agent, :string

    belongs_to :link, RedirectTo.Link

    timestamps
  end

  @required_fields ~w(user_agent link_id)
  @optional_fields ~w(ip referer)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
