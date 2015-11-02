defmodule RedirectTo.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :long_url, :string
      add :slug, :string

      timestamps
    end

  end
end
