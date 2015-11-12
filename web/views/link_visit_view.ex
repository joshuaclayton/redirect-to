defmodule RedirectTo.LinkVisitView do
  use RedirectTo.Web, :view
  import RedirectTo.UserAgent

  def date_format(value) do
    {:ok, date} = Ecto.DateTime.dump(value)
    Timex.Date.from(date)
    |> Timex.DateFormat.format!("%B %e, %Y", :strftime)
  end

  def user_agent_info(link_visit) do
    link_visit.user_agent
    |> user_agent_breakdown
    |> Enum.join "/"
  end

  def referer_host(link_visit) do
    link_visit.referer
    |> retrieve_host
  end

  defp user_agent_breakdown(user_agent) do
    [browser_name(user_agent), os_name(user_agent), device_name(user_agent)]
  end

  defp retrieve_host(nil), do: ""
  defp retrieve_host(referer) do
    case URI.parse(referer) do
      %URI{host: nil} -> ""
      %URI{host: host} -> host
    end
  end
end
