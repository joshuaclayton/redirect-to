defmodule RedirectTo.Repo.Migrations.IndexSlugOnLinks do
  use Ecto.Migration

  def change do
    create index(:links, [:slug], unique: true)
  end
end
