defmodule RedirectTo.UserAgent do
  def browser_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %{client: %{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def os_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %{os: %{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def device_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %{device: %{model: :unknown}} -> "Unknown"
      %{device: %{model: name}} -> name
      _ -> "Unknown"
    end
  end
end
