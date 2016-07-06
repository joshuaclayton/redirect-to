defmodule RedirectTo.LinkVisitView do
  use RedirectTo.Web, :view

  def date_format(value) do
    {:ok, date} = Ecto.DateTime.dump(value)
    {:ok, result} = Timex.DateTime.from(date) |> Timex.format("%B %e, %Y %l:%M %p", :strftime)
    result
  end

  def user_agent_info(link_visit) do
    [link_visit.browser_name, link_visit.os_name, link_visit.device_name]
    |> Enum.join("/")
  end

  def referer_host(link_visit) do
    link_visit.referer
    |> retrieve_host
  end

  defp retrieve_host(nil), do: ""
  defp retrieve_host(referer) do
    case URI.parse(referer) do
      %URI{host: nil} -> ""
      %URI{host: host} -> host
    end
  end
end
