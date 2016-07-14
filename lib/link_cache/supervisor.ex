defmodule LinkCache.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(LinkCache.Cache, [[name: LinkCache.Cache]])
    ]

    create_cache_table

    supervise(children, strategy: :one_for_one)
  end

  def create_cache_table do
    :ets.new(LinkCache.Cache, [:named_table, :duplicate_bag, :public, read_concurrency: true])
  end
end
