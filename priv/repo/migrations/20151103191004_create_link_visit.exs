defmodule RedirectTo.Repo.Migrations.CreateLinkVisit do
  use Ecto.Migration

  def change do
    create table(:link_visits) do
      add :ip, :string
      add :referer, :string
      add :user_agent, :string
      add :link_id, references(:links)

      timestamps
    end
    create index(:link_visits, [:link_id])

  end
end
