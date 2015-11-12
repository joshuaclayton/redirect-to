defmodule RedirectTo.UserAgent do
  def user_agent_breakdown(user_agent) do
    parsed_result = UaInspector.parse(user_agent)
    [browser_name(parsed_result), os_name(parsed_result), device_name(parsed_result)]
  end

  def browser_name(parsed_result) do
    case parsed_result do
      %{client: %{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def os_name(parsed_result) do
    case parsed_result do
      %{os: %{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def device_name(parsed_result) do
    case parsed_result do
      %{device: %{model: :unknown}} -> "Unknown"
      %{device: %{model: name}} -> name
      _ -> "Unknown"
    end
  end
end
