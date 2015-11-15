defmodule RedirectTo.Queries.LinksList do
  import Ecto.Query, only: [from: 2]
  alias RedirectTo.Link

  def with_visits_count do
    from l in Link,
      left_join: lv in assoc(l, :link_visits),
      group_by: l.id,
      select: {l, count(lv.id)},
      order_by: l.id
  end
end

