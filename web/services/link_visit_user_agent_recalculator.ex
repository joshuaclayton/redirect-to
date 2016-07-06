defmodule RedirectTo.LinkVisitUserAgentRecalculator do
  import RedirectTo.UserAgent, only: [user_agent_to_map: 1]
  alias RedirectTo.Repo
  alias Ecto.Changeset

  def recalculate(records) do
    records
    |> Enum.each(&update_link_visit/1)
  end

  defp update_link_visit(link_visit) do
    link_visit
    |> Changeset.change(user_agent_to_map(link_visit.user_agent))
    |> Repo.update
  end
end
