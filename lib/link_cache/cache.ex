defmodule LinkCache.Cache do
  def start_link(_opts \\ []) do
    :ets.new(__MODULE__, [:named_table, :duplicate_bag, :public, read_concurrency: true])
    {:ok, self()}
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
    :ets.insert(__MODULE__, {slug, value})
    value
  end
end
