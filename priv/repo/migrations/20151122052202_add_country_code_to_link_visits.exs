defmodule RedirectTo.Repo.Migrations.AddCountryCodeToLinkVisits do
  use Ecto.Migration

  def change do
    alter table(:link_visits) do
      add :country_code, :string
    end
  end
end
