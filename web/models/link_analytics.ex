defmodule RedirectTo.LinkAnalytics do
  import Ecto.Query, only: [from: 2]
  alias RedirectTo.LinkVisit
  alias RedirectTo.Repo

  defstruct device_breakdown: [], os_breakdown: [], browser_breakdown: [], country_breakdown: [], total: 0

  def generate(link) do
    total = calculate_total(link)

    %__MODULE__{}
    |> Map.merge(%{device_breakdown: calculate_devices(link, total)})
    |> Map.merge(%{os_breakdown: calculate_oses(link, total)})
    |> Map.merge(%{browser_breakdown: calculate_browsers(link, total)})
    |> Map.merge(%{country_breakdown: calculate_countries(link, total)})
    |> Map.merge(%{total: total})
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

  defp calculate_countries(link, total) do
    from(lv in LinkVisit,
      select: %{name: lv.country_code, count: count(lv.country_code)},
      group_by: lv.country_code,
      where: lv.link_id == ^link.id,
      order_by: [desc: count(lv.country_code)]
    ) |> Repo.all
    |> include_percentage(total)
  end

  defp include_percentage(list, total) do
    list
    |> Enum.map(fn(data = %{count: count}) ->
      data
      |> Map.merge(%{percentage: ((count/total)*100) |> Float.round(1)})
    end)
  end

  defp calculate_total(link) do
    from(
      l in RedirectTo.Link,
      select: l.link_visits_count,
      where: l.id == ^link.id
    )
    |> Repo.one
  end
end
