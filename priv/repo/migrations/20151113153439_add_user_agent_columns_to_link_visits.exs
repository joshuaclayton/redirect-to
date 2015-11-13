defmodule RedirectTo.Repo.Migrations.AddUserAgentColumnsToLinkVisits do
  use Ecto.Migration

  def change do
    alter table(:link_visits) do
      add :browser_name, :string, null: false, default: ""
      add :os_name, :string, null: false, default: ""
      add :device_name, :string, null: false, default: ""
    end
  end
end
