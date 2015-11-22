defmodule RedirectTo.LinkView do
  use RedirectTo.Web, :view

  def flag_active(current_link, active_link) do
    if active_link && active_link.id == current_link.id do
      "class=active"
    end
  end

  def link_creation(conn, link) do
    t(conn, "link.creation", timestamp: RedirectTo.LinkVisitView.date_format(link.inserted_at))
  end
end
