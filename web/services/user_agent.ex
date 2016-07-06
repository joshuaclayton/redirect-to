defmodule RedirectTo.UserAgent do
  def user_agent_to_map(user_agent) do
    parsed_user_agent = UAInspector.parse(user_agent)

    %{
      browser_name: browser_name(parsed_user_agent),
      device_name: device_name(parsed_user_agent),
      os_name: os_name(parsed_user_agent)
    }
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
