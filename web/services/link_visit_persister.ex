defmodule RedirectTo.LinkVisitPersister do
  alias RedirectTo.Repo
  alias RedirectTo.Link
  alias RedirectTo.LinkVisit
  import Ecto.Query, only: [from: 2]

  def persist(attributes) do
    {:ok, link_visit} = Repo.transaction fn ->
      LinkVisit.changeset(%LinkVisit{}, attributes)
      |> Repo.insert!
      |> increment_link_visit_count
    end

    link_visit
  end

  defp increment_link_visit_count(changeset) do
    from(l in Link, where: l.id == ^changeset.link_id)
    |> Repo.update_all(inc: [link_visits_count: 1])

    changeset
  end
end
