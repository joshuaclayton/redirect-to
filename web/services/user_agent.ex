defmodule RedirectTo.UserAgent do
  def browser_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %UaInspector.Result{client: %UaInspector.Result.Client{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def os_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %UaInspector.Result{os: %UaInspector.Result.OS{name: name}} -> name
      _ -> "Unknown"
    end
  end

  def device_name(user_agent) do
    case UaInspector.parse(user_agent) do
      %UaInspector.Result{device: %UaInspector.Result.Device{model: :unknown}} -> "Unknown"
      %UaInspector.Result{device: %UaInspector.Result.Device{model: name}} -> name
      _ -> "Unknown"
    end
  end
end
