defmodule RedirectTo.LinkView do
  use RedirectTo.Web, :view

  def flag_active(current_link, active_link) do
    if active_link && active_link.id == current_link.id do
      "class=active"
    end
  end
end
