defmodule RedirectTo.LinkVisit do
  use RedirectTo.Web, :model

  schema "link_visits" do
    field :ip, :string
    field :referer, :string
    field :user_agent, :string
    field :browser_name, :string
    field :os_name, :string
    field :device_name, :string
    field :country_code, :string

    belongs_to :link, RedirectTo.Link

    timestamps
  end

  after_insert :increment_link_visit_count

  def increment_link_visit_count(changeset = %{model: model}) do
    from(l in RedirectTo.Link, where: l.id == ^model.link_id)
    |> RedirectTo.Repo.update_all(inc: [link_visits_count: 1])

    changeset
  end

  @required_fields ~w(user_agent link_id browser_name os_name device_name)
  @optional_fields ~w(ip referer country_code)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
