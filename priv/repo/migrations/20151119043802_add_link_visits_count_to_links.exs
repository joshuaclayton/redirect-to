defmodule RedirectTo.Repo.Migrations.AddLinkVisitsCountToLinks do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :link_visits_count, :integer, default: 0
    end
  end
end
