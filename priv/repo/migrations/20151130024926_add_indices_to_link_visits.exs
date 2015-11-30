defmodule RedirectTo.Repo.Migrations.AddIndicesToLinkVisits do
  use Ecto.Migration

  def change do
    create index(:link_visits, [:device_name])
    create index(:link_visits, [:os_name])
    create index(:link_visits, [:country_code])
    create index(:link_visits, [:browser_name])
  end
end
