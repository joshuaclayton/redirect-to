defmodule RedirectTo.LinkAnalytics do
  import Ecto.Query, only: [from: 2]
  alias RedirectTo.LinkVisit
  alias RedirectTo.Repo

  defstruct device_breakdown: [], os_breakdown: [], browser_breakdown: []

  def generate(link) do
    total = calculate_total(link)

    %__MODULE__{}
    |> Map.merge(%{device_breakdown: calculate_devices(link, total)})
    |> Map.merge(%{os_breakdown: calculate_oses(link, total)})
    |> Map.merge(%{browser_breakdown: calculate_browsers(link, total)})
  end

  defp calculate_devices(link, total) do
    from(lv in LinkVisit,
      select: %{name: lv.device_name, count: count(lv.device_name)},
      group_by: lv.device_name,
      where: lv.link_id == ^link.id,
      order_by: [desc: count(lv.device_name)]
    ) |> Repo.all
    |> include_percentage(total)
  end

  defp calculate_oses(link, total) do
    from(lv in LinkVisit,
      select: %{name: lv.os_name, count: count(lv.os_name)},
      group_by: lv.os_name,
      where: lv.link_id == ^link.id,
      order_by: [desc: count(lv.os_name)]
    ) |> Repo.all
    |> include_percentage(total)
  end

  defp calculate_browsers(link, total) do
    from(lv in LinkVisit,
      select: %{name: lv.browser_name, count: count(lv.browser_name)},
      group_by: lv.browser_name,
      where: lv.link_id == ^link.id,
      order_by: [desc: count(lv.browser_name)]
    ) |> Repo.all
    |> include_percentage(total)
  end

  defp include_percentage(list, total) do
    list
    |> Enum.map fn(data = %{count: count}) ->
      data
      |> Map.merge(%{percentage: ((count/total)*100) |> Float.round(1)})
    end
  end

  defp calculate_total(link) do
    from(
      lv in LinkVisit,
      where: lv.link_id == ^link.id,
      select: count(lv.id)
    ) |> Repo.one
  end
end
