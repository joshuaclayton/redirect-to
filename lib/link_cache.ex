defmodule LinkCache do
  use GenServer

  def start_link(opts \\ []) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [
      {:ets_table_name, :link_cache_table},
      {:log_limit, 1000000}
    ], opts)
  end

  def fetch(slug, default_value_function) do
    case get(slug) do
      nil -> set(slug, default_value_function.())
      result -> result
    end
  end

  def get(slug) do
    case GenServer.call(__MODULE__, {:get, slug}) do
      [] -> nil
      [{_slug, result}] -> result
    end
  end

  def set(slug, value) do
    GenServer.call(__MODULE__, {:set, slug, value})
  end

  def handle_call({:get, slug}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, slug)
    {:reply, result, state}
  end

  def handle_call({:set, slug, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {slug, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args

    :ets.new(ets_table_name, [:named_table, :set, :private])

    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end
end
