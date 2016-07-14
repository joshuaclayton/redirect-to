defmodule LinkCache.Cache do
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def fetch(slug, default_value_function) do
    case get(slug) do
      {:not_found} -> set(slug, default_value_function.())
      {:found, result} -> result
    end
  end

  defp get(slug) do
    case :ets.lookup(__MODULE__, slug) do
      [] -> {:not_found}
      [{_slug, result}] -> {:found, result}
    end
  end

  defp set(slug, value) do
    :ok = GenServer.cast(__MODULE__, {:set, slug, value})
    value
  end

  def handle_cast({:set, slug, value}, state) do
    true = :ets.insert(__MODULE__, {slug, value})
    {:noreply, state}
  end
end
